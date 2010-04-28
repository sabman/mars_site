class AddRegionsUserId < ActiveRecord::Migration
  def self.up
    change_table :regions do |t|
      t.references  :user
    end
    add_index :regions, :user_id
  #  execute <<-SQL
  #    ALTER TABLE regions
  #    ADD CONSTRAINT fk_regions_users
  #    FOREIGN KEY (user_id)
  #    REFERENCES regions(id)
  #  SQL
  end

  def self.down
    remove_index :regions, :user_id
    change_table :regions do |t|
      t.remove_references :user
    end
  end
end
