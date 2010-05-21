#$:.unshift(File.join(File.dirname(__FILE__), 'spatial_adapter', 'lib'))

require 'rubygems'
require 'active_record'
require 'geo_ruby'
require 'oci8'
require File.join('active_record', 'connection_adapters', 'oracle_enhanced_adapter')
require File.join('lib', 'sdo_geometry')
require File.join('lib', 'oci8_hack')
require File.join('lib', 'array')
require File.join('lib', 'config','inflections')

include GeoRuby::SimpleFeatures

DB_CONFIG = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)), 'config', 'database.yml'))
