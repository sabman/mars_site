class Sample < Prod::Sample
  acts_as_commentable
  belongs_to :survey, :foreign_key => "eno"
  has_many :sampledata, :foreign_key => "sampleno"

  #after_create :update_samples_count_for_survey
  #after_destroy :update_samples_count_for_survey
  
  attr_accessor :lat_start, :lon_start, :lat_end, :lon_end

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

  def mean_grain_size
    data = self.sampledata.find_all_by_property('grain size', :order => "datano ASC")
    running_mean = []
    running_sum = []
    lt_63 = []
    bw_63_2000 = []
    gt_2000 = []
    data.each do |d|
      d.qualifier =~ /(\d+|\d+\.\d+)um - (\d+|\d+\.\d+)um/i
      if ($1 && $2) && ($2 > $1)
        puts "#{$1}\t-\t#{$2}\t#{d.quant_value} #{d.uom}" 
        mean = (($2.to_f-$1.to_f)/2)+$1.to_f
        running_mean << mean * d.quant_value.to_f
        running_sum << d.quant_value.to_f
        if $2.to_f < 63
          lt_63 << d.quant_value
        elsif $1.to_f >= 63 && $2.to_f <= 2000
          bw_63_2000 << d.quant_value
        elsif $1.to_f >= 2000
          gt_2000 << d.quant_value
        end
      end
    end
    puts "total:  \t #{running_sum.sum}"
    puts "<63:    \t #{lt_63.sum}"
    puts "63-2000:\t #{bw_63_2000.sum}"
    puts ">2000:  \t #{gt_2000.sum}"
    running_mean.sum/running_sum.sum
  end
end
