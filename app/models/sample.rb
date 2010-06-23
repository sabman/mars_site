class Sample < Prod::Sample
  acts_as_commentable
  belongs_to :survey, :foreign_key => "eno"
  has_many :sampledata, :foreign_key => "sampleno"
  named_scope :ga_only, :conditions => "access_code = 'A'"

  #auto_complete_for :survey, :operator do 
  #  Lookup.operators 
  #end

  #after_create :update_samples_count_for_survey
  #after_destroy :update_samples_count_for_survey

  attr_accessor :lat_start, :lon_start, :lat_end, :lon_end, :country, :feature

  def feature
    a = self.attributes; a.delete("geom"); a.delete("geom_original")
    { 
      :id => self.id,
      :geometry => self.geom.try(:as_georuby), 
      :properties => a 
    }
  end

  def has_laser?
    sampledata.find_by_method("Laser") != nil
  end
  def has_sieve?
    sampledata.find_by_method("Sieve") != nil
  end

  def laser_summary
    return nil unless self.has_laser?
    q1 = sampledata.find_by_method_and_qualifier_and_seq_no("Laser", "d (0.1)", 1.0)
    q2 = sampledata.find_by_method_and_qualifier_and_seq_no("Laser", "d (0.2)", 1.0)
    q3 = sampledata.find_by_method_and_qualifier_and_seq_no("Laser", "d (0.5)", 1.0)
    q4 = sampledata.find_by_method_and_qualifier_and_seq_no("Laser", "d (0.8)", 1.0)
    q5 = sampledata.find_by_method_and_qualifier_and_seq_no("Laser", "d (0.9)", 1.0)
    [q1,q2,q3,q4,q5]
  end


  def station_number
    expr = /^\w\d\w\d.*$/
  end

  def potential_parents
    find_all_by_sampleid( {:conditions => ["sampleid LIKE ?", %{survey.surveyid}]})
  end

  # does this sample have children
  def children
    Sample.find_all_by_parent(sampleno)
  end

  def self.find_all_by_region(region)
    bbox = region.corners.split(',').map{|c| c.to_f }
    self.find_all_by_bbox(bbox)
  end

  def self.bbox_search_conditions(g)
    ["SDO_ANYINTERACT(#{table_name}.geom, #{g.as_sdo_geometry}) = 'TRUE'"]
  end

  def all_grain_size_data
    sampledata.find_all_by_property('grain size')
  end

  def sieve_grain_size
    data = self.sampledata.find_all_by_property_and_method('grain size', 'Sieve', :order => "datano ASC")
    return nil if data.empty?
    data
  end

  def bulk_geometric_mean
    return nil if sampledata.blank?
    data = sampledata.find_all_by_qualifier('geometric mean (bulk)')
    return nil if data.blank?
    data
  end

  def bulk_geometric_sorting
    return nil if sampledata.blank?
    data = sampledata.find_all_by_qualifier('geometric sorting (bulk)')
    return nil if data.blank?
    data
  end

  def bulk_geometric_skewness
    return nil if sampledata.blank?
    data = sampledata.find_all_by_qualifier('geometric skewness (bulk)')
    return nil if data.blank?
    data
  end

  def geometric_mean_grain_size
    data = self.sampledata.find_all_by_property_and_method('grain size', 'Laser', :order => "datano ASC")
    return if data.empty?
    running_mean = []
    running_sum = []
    lt_63 = []
    bw_63_2000 = []
    gt_2000 = []
    data.each do |d|
      d.qualifier =~ /(\d+|\d+\.\d+)um\s*-\s*(\d+|\d+\.\d+)um/i
      if ($1 && $2) && ($2.to_f - $1.to_f >= 0)
        mid_bin = (($2.to_f-$1.to_f)/2)+$1.to_f
        #puts "min bin: " + mid_bin.to_s
        ln_mid_bin = Math.log(mid_bin)
        #puts "log min bin: " + ln_mid_bin.to_s
        running_mean << ln_mid_bin * d.quant_value.to_f
        running_sum << d.quant_value.to_f
        #puts "#{$1}\t-\t#{$2}\t#{d.quant_value} #{d.uom}\t#{mid_bin}\t#{ln_mid_bin}\t#{running_mean.last}" 
        if $2.to_f < 63
          lt_63 << d.quant_value
        elsif $1.to_f >= 63 && $2.to_f <= 2000
          bw_63_2000 << d.quant_value
        elsif $1.to_f >= 2000
          gt_2000 << d.quant_value
        end
      end
    end
    #puts "total:  \t #{running_sum.sum}"
    #puts "<63:    \t #{lt_63.sum}"
    #puts "63-2000:\t #{bw_63_2000.sum}"
    #puts ">2000:  \t #{gt_2000.sum}"
    #puts running_mean.sum
    Math.exp(running_mean.sum/100)
  end

    def self.find_all_by_bbox(bounds, opts={})
      bbox = GeoRuby::SimpleFeatures::Polygon.from_coordinates(bounds.as_coordinates, 4326)
      self.find_all_by_geom(bbox, opts)
    end

    def self.find_all_by_geom(g, opts={})
      # TODO Handle options as done by find methods in rails
      raise "Currently only handles conditions passed as string" if opts[:conditions].is_a?(Array)
      conditions = ["SDO_ANYINTERACT(#{table_name}.geom, #{g.as_sdo_geometry}) = 'TRUE'"]
      conditions = [conditions, "(#{opts[:conditions]})"].join(' AND ') unless( opts[:conditions].nil? || opts[:conditions].try(:empty?) )
#      puts conditions
      Sample.find(:all, :conditions => conditions)
    end

    comma :sampledata do
      survey :surveyname
      survey :surveyid
      survey :startdate
      survey :enddate
      sampleno
      sampleid
      sample_type
      top_depth
      base_depth
      start_lon
      start_lat
      start_depth
      end_lon
      end_lat
      end_depth 
      access_code
      acquiredate
      comments
      eno
      grain_size_mud
      grain_size_sand
      grain_size_gravel
      grain_size_bulk
      grain_size_mean
      carbonate_content_mud
      carbonate_content_sand
      carbonate_content_gravel
      carbonate_content_bulk
      biogenic_silica_average
      biogenic_silica_stddev
      start_water_depth
      end_water_depth
      rock_type_qual_values
      munsell_colours_qual_values
      sedimentry_structures_qual_values
    end
end
