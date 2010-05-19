class Survey < Prod::Survey
  attr_accessor :gams, :operators, :samples_count, :title, :country, :participants, :start_port, :end_port, :state
  has_many :samples, :foreign_key => "eno"
  set_date_columns :entrydate, :qadate, :acquiredate, :confid_until, :lastupdate


  # scopes
  default_scope :conditions =>  "surveytype='MARINE' OR on_off='OnOff'"
  named_scope :recent, lambda{ |*args| {:conditions => "startdate > \'#{args.first || 2.years.ago.strftime('%d-%b-%Y')}\'" } }
  named_scope :marine, :conditions => "surveytype = 'MARINE'"
  named_scope :land, :conditions => "surveytype = 'LAND'"
  named_scope :ran, {:conditions => ["
      upper(operator) LIKE ? OR 
      upper(operator) LIKE ? OR 
      upper(operator) LIKE ? OR 
      upper(operator) LIKE ? OR 
      upper(operator) LIKE ? OR
      upper(owner) LIKE ? OR 
      upper(owner) LIKE ? OR 
      upper(owner) LIKE ? OR 
      upper(owner) LIKE ? OR 
      upper(owner) LIKE ?", 
      'RAN', '%AUSTRALIAN%NAVY%', '%AUSTRALIAN%HYDRO%', 'AHO', 'AHS', 'RAN', '%AUSTRALIAN%NAVY%', '%AUSTRALIAN%HYDRO%', 'AHO', 'AHS']}
  named_scope :antarctica, {:conditions => ["lower(operator) LIKE ? OR lower(surveyname) LIKE ?", 'australian antarctic division', '%aurora australis%']}
  named_scope :upcoming, lambda{ {:conditions => "startdate > \'#{Time.now.strftime('%d-%b-%Y')}\' "} }

  @@critical_metadata_fields = %w{surveyname surveytype surveyid operator contractor processor client owner startdate enddate vessel_type vessel confid_until}

  def has_samples?;samples.count > 0;end

  def status
    return :unknown   if self.enddate.nil? 
    return :completed if Time.now > self.enddate
    return :upcoming if Time.now < self.enddate
    return :inprogress if Time.now <= self.enddate && Time.now >= self.startdate
  end

  def country
    Lookup.find_country_by_countryid(self.countryid).try(:countryname)
  end
  def country=(countryid) # stores countryid 
    self.countryid = countryid
  end

  def participants
    self.comments =~ /^PARTICIPANTS\s*=\s*(.*)\s*;$/
    $1
  end
  def participants=(list)
    if self.comments.nil? # this is a fresh comment so just add
      self.comments = "PARTICIPANTS = #{list}\n"
    else # need to check if we had participants list before
      self.comments =~ /^PARTICIPANTS\s*=\s*(.*)\s*;$/
      if $1.nil? # can't find participants
        self.comments = self.comments + "\n" + "PARTICIPANTS = #{list}\n" 
      else # found participants - replace them with the new list
        self.comments.gsub(/^PARTICIPANTS\s*=\s*(.*)\s*;$/, "PARTICIPANTS = #{list}\n")
      end
    end
  end

  def start_port
    self.comments =~ /^START PORT\s*=\s*(.*)\*;$/
    $1
  end
  def start_port=(port)
    append_or_update_comments("START PORT", port) 
  end

  def end_port
    self.comments =~ /^END PORT\s*=\s*(.*)\*;$/
    $1
  end
  def end_port=(port)
    append_or_update_comments("END PORT", port) 
  end

  def title
    self.surveyname || self.surveyid || self.id
  end

  def mean_grain_size
    samples.each do |sample|
      sample.mean_grain_size
    end
  end

  def all_grain_size_data(opts = {})
    o = {:limit => false}.merge(opts)
    gs = []
    if o[:limit] 
      samples.each.with_index do |sample, i|
        sample.all_grain_size_data.each {|d| gs << d unless d.nil?}
        return gs if gs.size > 200
      end
    else
      samples.each do |sample|
        sample.all_grain_size_data.each {|d|  gs << d unless d.nil?}
      end
    end
    gs
  end

  def llur(opts={})
    b = self.bounding_box(:array=>true) 
    puts b
    return nil unless b
    return [ b[2], b[1], b[3], b[0] ] 
  end

  def bounding_box(opts={})
    return nil unless (nlat && slat && elong && wlong)
    return [nlat.to_f,slat.to_f,elong.to_f,wlong.to_f] if opts[:array]
    [nlat,slat,elong,wlong].join(",")
  end

  def bounding_box=(bbox)
    nlat, slat, elong, wlong = bbox.split(",").collect{|v| v.to_f}
  end

  def self.with_samples
    find(:all).collect{ |s| s.has_samples? }
  end

  def to_param
    if surveyid
      "#{id}-#{surveyid.to_s.parameterize.upcase}"
    else
      id.to_s
    end
  end

  def samples_missing_metadata(attrib)
    samples.inject([]) { |a, sm|  a << sm if sm.send(attrib).nil?; a }
  end

  def operators
    operators ||= self.find_by_sql("select company from companies") 
  end
  

#  def update_samples_count
#    sc = self.samples.count
#    # if the samples_count exits sub
#    if self.comments.nil?
#      self.comments = "samples_count = #{sc.to_s};"
#    elsif self.comments =~  /^samples_count = (\d+);$/i
#      self.comments.sub!(/^samples_count = (\d+);$/i, "samples_count = #{sc.to_s};")
#    else 
#      self.comments = "samples_count = #{sc.to_s};\n" + self.comments
#    end
#    self.save
#  end

  # samples_count cache
#  def samples_count
#    if self.comments =~ /^samples_count = (\d+);$/i 
#      sc = $1.to_i
#    elsif self.comments.nil?
#      sc = self.samples.count
#      self.comments = "samples_count = #{sc.to_s};\n"
#    else
#      sc = self.samples.count
#      begin  # try to save it to comments
#        self.comments = "samples_count = #{sc.to_s};\n" + self.comments
#        self.save
#      rescue => e
#        puts "Error: while trying to save samples_count to comments"
#        puts e.message
#        sc
#      end
#      sc
#    end
#  end


  # gams should be retrieved by looking for it in the surveyid or in comments
  def gams
    surveyid =~ /(GA-?(\d\d\d\d|\d\d\d))/i
    return $2.to_s.rjust(4, '0') if $2 
    # look in comments
    comments =~ /GAMS\s*=\s*(\d+);/i
    return $1.to_s.rjust(4, '0') if $1 
  end

  def gams=(gams)
    append_or_update_comments("GAMS", gams) 
  end

  def gada_data_url
    return "http://www.agso.gov.au:88/pmd-bin/search_data.cgi?GAID=#{gams}&dtype=all%20" if gams
    return nil
  end

  def gada_metadata_url
    return "http://www.agso.gov.au:88/pmd-bin/searchmeta.cgi?metastr=#{gams}&mode=GAID" if gams
    return nil
  end

  # QC methods
  # overview QC of the survey by knowing if its missing critical fields
  def missing_critical_metadata?
    @@critical_metadata_fields.each{|f| return true if send(f).nil?}
    return false
  end

  # finder method for qc
  def self.confid_until_1950_and_access_a_with_sediment_samples
    vs = Survey.all(:joins => :samples, 
                    :conditions => ["(surveys.confid_until = ? OR surveys.confid_until IS ?) AND surveys.access_code = ?", "1-Jan-1950", nil, "A"],
                    :select => "surveys.eno, surveys.surveyid, surveys.surveyname, surveys.confid_until, surveys.access_code, surveys.surveytype, surveys.comments, surveys.operator, surveys.contractor, surveys.processor, surveys.releasedate, surveys.client, surveys.owner, surveys.startdate, surveys.enddate, surveys.vessel, surveys.vessel_type")

#   vs ||= Survey.find(:all, :conditions => ["(confid_until = ? OR confid_until IS ?) AND access_code = ?", "1-Jan-1950", nil, "A"], :include => :samples)
#   vs = Survey.find_by_sql( <<SQL
                            
#              SELECT  v.eno, v.surveyid, 
#                  v.surveyname, v.confid_until, v.access_code, v.surveytype, 
#                  v.comments, v.operator, v.contractor, v.processor, v.releasedate,
#                  v.client, v.owner, v.startdate, v.enddate, v.vessel, v.vessel_type

#              FROM 
#                surveys v
#
#              WHERE ( 
#                (v.confid_until = '1-Jan-1950' OR v.confid_until IS NULL) 
#                AND v.access_code = 'A' 
#                AND v.surveytype = 'MARINE' 
#              )
#SQL
#    ) 
#    vs.map{|v| puts v.samples_count }
    vs
  end


  comma :default do
    eno
    surveyname 
    surveytype 
    surveyid 
    operator 
    contractor 
    processor 
    client 
    owner 
    startdate 
    enddate 
    vessel_type 
    vessel 
    access_code
    confid_until
    releasedate
    comments
    samples_count
  end

  def self.all_data(eno)
    self.find_by_sql <<-SQL
      SELECT  
        v.CONFID_UNTIL,v.ENO,v.SURVEYNAME,v.SURVEYTYPE,v.DATATYPES,v.UNO,v.SURVEYID,v.OPERATOR,v.CONTRACTOR,v.PROCESSOR,v.CLIENT,v.OWNER,v.LEGISLATION,v.COUNTRYID,v.STATE,v.PROJ_LEADER,v.ON_OFF,v.STARTDATE,v.ENDDATE,v.VESSEL_TYPE,v.VESSEL,v.SPACEMIN,v.SPACEMAX,v.LOCMETHOD,v.ACCURACY,v.GEODETIC_DATUM,v.PROJECTION,v.ACCESS_CODE,v.QA_CODE,v.RELEASEDATE,v.COMMENTS,v.ENTRYDATE,v.ENTEREDBY,v.LASTUPDATE,v.UPDATEDBY,v.NLAT,v.SLAT,v.ELONG,v.WLONG,v.ANO,v.DATA_ACTIVITY_CODE,
        s.PROCEDURENO,s.GEOM,s.COMMENTS,s.SOURCE,s.CONFID_UNTIL,s.GEOM_ORIGINAL,s.ACCURACY,s.ELEV_ACCURACY,s.ACQUISITION_METHODNO,s.ACQUISITION_SCALE,s.METHOD,s.COUNTRYID,s.STATEID,s.ONSHORE_FLAG,s.PROV_ENO,s.SAMPLENO,s.ENO,s.SAMPLEID,s.SAMPLE_TYPE,s.TOP_DEPTH,s.BASE_DEPTH,s.PARENT,s.ACCESS_CODE,s.ENTRYDATE,s.ENTEREDBY,s.LASTUPDATE,s.UPDATEDBY,s.QADATE,s.QABY,s.QA_STATUS_CODE,s.ACTIVITY_CODE,s.ORIGINATOR,s.ACQUIREDATE,s.ANO,
        d.DATANO,d.SAMPLENO,d.PROPERTY,d.QUALIFIER,d.SEQ_NO,d.QUANT_VALUE,d.QUAL_VALUE,d.CONFIDENCE,d.UOM,d.ACCESS_CODE,d.PARENT,d.ENTRYDATE,d.ENTEREDBY,d.LASTUPDATE,d.UPDATEDBY,d.QADATE,d.QABY,d.QA_STATUS_CODE,d.ACTIVITY_CODE,d.ANALYSISDATE,d.ANO,d.CONFID_UNTIL,d.OBS_TYPE,d.BATCHNO,d.PREFERRED,d.COMMENTS,d.METHOD,d.PROJECTID,d.PROCEDURENO
      FROM 
        surveys v, samples s, sampledata d
      WHERE 
        1=1
        and s.eno = v.eno
        and s.sampleno = d.sampleno 
        and s.eno = #{eno}
    SQL
  end
  
  private
  def append_or_update_comments(key, value)
    if self.comments.nil? # this is a fresh entry to comments so just add
      self.comments = "#{key} = #{value};\n"
    else # need to check if key already exists
      self.comments =~ /^\s*(#{key})\s*=.*;$/
      if $1.nil? # can't find key so append 
        self.comments = self.comments + "\n" + "#{key} = #{value};\n" 
      else # found key - replace them with the value
        self.comments = self.comments.sub(/^\s*#{key}\s*=\s*(.*)\s*;$/, "#{key} = #{value};")
      end
    end
  end
end
