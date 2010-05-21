require 'lib/schema_common.rb'

# ============= Connect to oracle spatial production database =============
begin
  class ProdDb < ActiveRecord::Base
    establish_connection(DB_CONFIG['production'])
    self.logger = Logger.new(STDOUT)
    connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
  end
rescue Exception => e
  pp "#{e.message}: might I recommend SQL+ to fix this" if e.is_a?(OCISuccessWithInfo) 
  pp e.message
end

# ==============================================================
# add spatial support from georuby and common spatial adapter
# These should be added AFTER the AR connection is established otherwise you will get
# "uninitialized constant ActiveRecord::..." error 
require 'lib/spatial_adapter/lib/common_spatial_adapter' # WARNING: MAKE SURE THIS IS AFTER AR CONNECTION IS ESTABLISHED
require 'lib/oracle_spatial_adapter'

# load models
require 'lib/models/prod/entity'
require 'lib/models/prod/survey'
require 'lib/models/prod/sample'
require 'lib/models/prod/sampledata'
