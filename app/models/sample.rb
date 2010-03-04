class Sample < Prod::Sample
  belongs_to :survey, :foreign_key => "eno"
  has_many :sampledata, :foreign_key => "sampleno"

  after_create :update_samples_count_for_survey
  after_destroy :update_samples_count_for_survey
  
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

  def update_sample_count_for_survey
    survey.update_samples_count
  end
end
