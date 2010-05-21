ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
  include SpatialAdapter

  alias :original_native_database_types :native_database_types
  def native_database_types
    original_native_database_types.merge!(geometry_data_types)
  end
  
  alias :original_quote :quote
  #Redefines the quote method to add behaviour for when a Geometry is encountered
  def quote(value, column = nil)
    if value.kind_of?(GeoRuby::SimpleFeatures::Geometry)
      value.as_sdo_geometry
    else
      original_quote(value,column)
    end
  end  
end

# TODO: add spatial function support for geom columns
# ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
#   def find_by_geom(g)
#     
#   end
#  def self.get_conditions(attrs)
#    pp attrs
#    attrs.map do |attr, value|
#      attr = attr.to_s
#      if columns_hash[attr].sql_type == "SDO_GEOMETRY"
#        if value.is_a?(Array)
#          bbox = GeoRuby::SimpleFeatures::Polygon.from_coordinates(value.as_coordinates)
#          attrs[attr.to_sym] = bbox.as_sdo_geometry
#          # SDO_ANYINTERACT(geometry1,geometry2) = 'TRUE' 
#          "SDO_ANYINTERACT(#{table_name}.#{connection.quote_column_name(attr)}, ?) = 'TRUE'" 
#        end
#      end
#    end.join('AND')
#  end
# end
