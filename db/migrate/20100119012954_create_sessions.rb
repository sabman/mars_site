class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table "sburq.sessions" do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index "sburq.sessions", :session_id, :name => "i_sburq_sessions_sessions_id"
    add_index "sburq.sessions", :updated_at, :name => "i_sburq_sessions_updated_at"

  end

  def self.down
    drop_table "sburq.sessions"
  end
end
