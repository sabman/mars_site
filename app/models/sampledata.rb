class Sampledata < Prod::Sampledata
  belongs_to :sample, :foreign_key => "sampleno"
  # I should be able to get all the rock type 
  named_scope :rocks, :conditions => {:property => 'rock type'} 
end
