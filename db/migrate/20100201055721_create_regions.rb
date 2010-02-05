class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :name
      t.string :coordinates
      t.string :corners
      t.decimal :minlon
      t.decimal :maxlon
      t.decimal :minlat
      t.decimal :maxlat
      t.timestamps
    end
  end
  
  def self.down
    drop_table :regions
  end
end
