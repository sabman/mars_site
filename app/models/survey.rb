class Survey < Prod::Survey
  attr_accessor :gams, :operators, :samples_count

  has_many :samples, :foreign_key => "eno"

  @@critical_metadata_fields = %w{surveyname surveytype surveyid operator contractor processor client owner startdate enddate vessel_type vessel confid_until}

  def has_samples?;samples.count > 0;end

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
    surveyid =~ /(GA-?(\d\d\d|\d\d\d\d))/i
    return $2.to_s.rjust(4, '0') if $2 
    # look in comments
    comments =~ /GAMS=(\d+);/i
    return $1.to_s.rjust(4, '0') if $1 
  end

  def gams=(gams)
    
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
    #vs ||= Survey.find(:all, :conditions => ["(confid_until = ? OR confid_until IS ?) AND access_code = ?", "1-Jan-1950", nil, "A"], :include => :samples)
    vs = Survey.all(:joins => :samples, 
                    :conditions => ["(surveys.confid_until = ? OR surveys.confid_until IS ?) AND surveys.access_code = ?", "1-Jan-1950", nil, "A"],
                    :select => "surveys.eno, surveys.surveyid, surveys.surveyname, surveys.confid_until, surveys.access_code, surveys.surveytype, surveys.comments, surveys.operator, surveys.contractor, surveys.processor, surveys.releasedate, surveys.client, surveys.owner, surveys.startdate, surveys.enddate, surveys.vessel, surveys.vessel_type")

#    vs = Survey.find_by_sql( <<SQL
                            
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
end
