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
end
