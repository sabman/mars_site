class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table "sburq.regions" do |t|
      t.string  :name
      t.text    :geometry
      t.string  :coordinates
      t.string  :corners
      t.decimal :minlon, :precision => 10, :scale => 6
      t.decimal :maxlon, :precision => 10, :scale => 6
      t.decimal :minlat, :precision => 10, :scale => 6
      t.decimal :maxlat, :precision => 10, :scale => 6
      t.timestamps
    end
  end
  
  def self.down
    drop_table "sburq.regions"
  end
end
