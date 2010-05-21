String.class_eval do
  def to_json
    llur = self.to_array.as_coordinates
    g = GeoRuby::SimpleFeatures::Polygon.from_coordinates(llur, 4326, false)
    g.to_json
  end

  def to_array
    llur = self.split(",").collect{|c| c.to_f}
  end

  def to_georuby
    llur = self.to_coordinates
    GeoRuby::SimpleFeatures::Polygon.from_coordinates(llur, 4326)
  end
end
