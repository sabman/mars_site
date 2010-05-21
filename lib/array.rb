# given an array of lower-left and upper-right coordinates
# convert them to an array of polygon coordinates
Array.class_eval do 
  def as_coordinates
    raise "#{self.join(',')} should have 4 numeric values: [minlon, minlat, maxlon, maxlat]" if self.size != 4
    v = {:minlon => 0, :maxlon => 2, :minlat => 1, :maxlat => 3}
    ll = [ self[v[:minlon]], self[v[:minlat]] ]
    lr = [ self[v[:maxlon]], self[v[:minlat]] ]
    ur = [ self[v[:maxlon]], self[v[:maxlat]] ]
    ul = [ self[v[:minlon]], self[v[:maxlat]] ]
    [[ll, lr, ur, ul, ll]]
  end

  def as_geom
    GeoRuby::SimpleFeatures::Polygon.from_coordinates(self.as_coordinates, 4326)
  end
end


