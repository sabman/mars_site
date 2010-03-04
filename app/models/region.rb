class Region < ActiveRecord::Base
  attr_accessible :name, :coordinates, :corners, :minlon, :maxlon, :minlat, :maxlat, :geometry, :geom
  alias_attribute :geom, :geometry

  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end
end
