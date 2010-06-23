class Region < ActiveRecord::Base
  belongs_to :user
  #set_table_name "sburq.regions"
  attr_accessible :name, :coordinates, :corners, :minlon, :maxlon, :minlat, :maxlat, :geometry, :geom
  alias_attribute :geom, :geometry
  before_save :update_lat_lon

  def samples
    Sample.find_all_by_region(self) 
  end

  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def update_lat_lon
    self.minlon = self.corners.split(",")[0].to_f 
    self.minlat = self.corners.split(",")[1].to_f 
    self.maxlon = self.corners.split(",")[2].to_f 
    self.maxlat = self.corners.split(",")[3].to_f 
  end

  def corners_to_geojson
    llur = corners.split(",").collect{|c| c.to_f}
    llur = llur.as_coordinates
    g = GeoRuby::SimpleFeatures::Polygon.from_coordinates(llur, 4326, false)
    g.to_json
  end

  def to_geom
    llur = corners.split(",").collect{|c| c.to_f}
    llur = llur.as_coordinates
    GeoRuby::SimpleFeatures::Polygon.from_coordinates(llur, 4326, false)
  end

  def feature
    JSON.parse(self.geometry)
  end

end
