module Prod
  class Entity < ProdDb
    set_table_name :entities
    set_primary_key :eno
    has_one :survey, :foreign_key => :eno, :class_name => "Prod::Survey"
  end
end
