require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Survey do
  before(:each) do
    @valid_attributes = {
      :eno => 1,
      :surveyid => "value for surveyid",
      :surveyname => "value for surveyname",
      :surveytype => "value for surveytype",
      :datatypes => "value for datatypes",
      :uno => "value for uno",
      :operator => "value for operator",
      :contractor => "value for contractor",
      :processor => "value for processor",
      :client => "value for client",
      :owner => "value for owner",
      :legislation => "value for legislation",
      :countryid => "value for countryid",
      :state => "value for state",
      :proj_leader => "value for proj_leader",
      :on_off => "value for on_off",
      :startdate => Date.today,
      :enddate => Date.today,
      :vessel_type => "value for vessel_type",
      :spacemin => 1,
      :spacemax => 1,
      :locmethod => "value for locmethod",
      :accuracy => 1,
      :geodetic_datum => "value for geodetic_datum",
      :projection => "value for projection",
      :access_code => "value for access_code",
      :qa_code => "value for qa_code",
      :releasedate => Date.today,
      :comments => "value for comments",
      :entrydate => Date.today,
      :enteredby => "value for enteredby",
      :lastupdate => Date.today,
      :updatedby => "value for updatedby",
      :data_activity_code => "value for data_activity_code",
      :nlat => 9.99,
      :slat => 9.99,
      :elong => 9.99,
      :wlong => 9.99,
      :ano => 1,
      :qaby => "value for qaby",
      :qadate => Date.today,
      :confid_until => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Survey.create!(@valid_attributes)
  end
end
