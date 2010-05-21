module Prod
  class Survey < ProdDb
    set_table_name :surveys
    set_primary_key :eno
    has_many :samples, :foreign_key => :eno, :class_name => "Prod::Sample"
    belongs_to :entity, :foreign_key => :eno, :class_name => "Prod::Entity"
  end
end
