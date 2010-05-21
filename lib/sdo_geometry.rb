require 'rubygems'
require 'geo_ruby' 
GeoRuby::SimpleFeatures::Geometry.class_eval do
  def sdo_srid
    @srid == 4326 ? 8311 : @srid
  end
end

GeoRuby::SimpleFeatures::Point.class_eval do
  def as_sdo_geometry
    "MDSYS.SDO_GEOMETRY(#{sdo_gtype},#{sdo_srid},SDO_POINT_TYPE(#{sdo_ordinate_array}),NULL,NULL)"     
  end
  
  # dl01 see http://download.oracle.com/docs/cd/b19306_01/appdev.102/b14255/sdo_objrelschema.htm#g1013735
  def sdo_gtype    
    d = @with_z ? 3 : 2
    l = @with_m ? (d==2 ? 3 : 4) : 0
    "#{d}#{l}01".to_i
  end
  
  def sdo_ordinate_array
    @with_z ? "#{@x},#{@y},#{@z}" : "#{@x},#{@y}, NULL"
  end
  
end
GeoRuby::SimpleFeatures::LineString.class_eval do
  def as_sdo_geometry
    "MDSYS.SDO_GEOMETRY(#{sdo_gtype},#{sdo_srid},null,SDO_ELEM_INFO_ARRAY(#{sdo_starting_offset},#{sdo_etype},#{sdo_interpretation}),SDO_ORDINATE_ARRAY(#{sdo_ordinate_array}))"
  end
  #sdo_geometry (2002, null, null, sdo_elem_info_array (1,2,1),sdo_ordinate_array (10,25, 20,30, 25,25, 30,30))
  # dl02 see http://download.oracle.com/docs/cd/B19306_01/appdev.102/b14255/sdo_objrelschema.htm#g1013735
  def sdo_gtype
    d = @with_z ? 3 : 2
    l = @with_m ? (d==2 ? 3 : 4) : 0
    "#{d}#{l}02".to_i
  end
  def sdo_starting_offset 
    1 
  end
  def sdo_etype 
    2 #linestring
  end
  def sdo_interpretation 
    1 # straigt lines
    # 2 # acrs # TODO: check if OGC SimpleFeatures supports arcs to connect verticies
  end
  def sdo_ordinate_array
    a = []
    if @with_z 
      @points.each{|p| a = a + [p.x,p.y,p.z]}
    else
      @points.each{|p| a = a + [p.x,p.y]}
    end
    a.join(',')
  end
end

GeoRuby::SimpleFeatures::Polygon.class_eval do
  def as_sdo_geometry
    "MDSYS.SDO_GEOMETRY(#{sdo_gtype},#{sdo_srid},null,SDO_ELEM_INFO_ARRAY(#{sdo_starting_offset},#{sdo_etype},#{sdo_interpretation}),SDO_ORDINATE_ARRAY(#{sdo_ordinate_array}))"
  end

  # dl03 POLYGON Geometry contains one polygon with or without holes
  def sdo_gtype
    d = @with_z ? 3 : 2
    l = @with_m ? (d==2 ? 3 : 4) : 0
    "#{d}#{l}03".to_i
  end
  def sdo_starting_offset 
    1 
  end
  def sdo_etype 
    3 #polygon
  end
  def sdo_interpretation 
    1 # straigt lines
    # 2 # acrs # TODO: check if OGC SimpleFeatures supports arcs to connect verticies
  end
  def sdo_ordinate_array
    a = []
    if @with_z 
      @rings[0].points.each{|p| a = a + [p.x,p.y,p.z]}
    else
      @rings[0].points.each{|p| a = a + [p.x,p.y]}
    end
    a.join(',')
  end
end
