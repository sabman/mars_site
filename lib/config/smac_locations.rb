require 'yaml'
locations_file = File.join(File.expand_path(File.dirname(__FILE__)), 'smac_locations.yml')
SMAC_LOCATIONS = YAML.load_file(locations_file)
#require 'pp'; pp SMAC_LOCATIONS
