# initialize the ActiveRecord support for GA's Oracle Spatial 
require File.join('lib', 'schema_prod')
#require File.join('lib', 'schema_dev')
#require File.join('utils', 'mars_helper')
#require File.join('utils', 'gml_helper')
require File.join('lib', 'geojson')
require 'fastercsv'
require 'comma'
include GeoRuby::SimpleFeatures
