require 'comma'
module Prod
  class Sampledata < ProdDb
    set_table_name :sampledata
    set_sequence_name :autogenerated 
    set_primary_key :datano
    belongs_to :sample, :foreign_key => :sampleno, :class_name => "Prod::Sample"
    comma :default do
      sampleno
      datano
      property
      qualifier
      quant_value
      uom
      method
      seq_no
    end
  end
end