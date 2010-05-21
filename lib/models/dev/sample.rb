module Dev
  class MySample < DevDb
    set_table_name :my_samples
    set_sequence_name :autogenerated 
    set_primary_key :sampleno
  end

  class Sample < DevDb
    set_table_name :samples
    set_sequence_name :autogenerated 
    set_primary_key :sampleno
  end
end


