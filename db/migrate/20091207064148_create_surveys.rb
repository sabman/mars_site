class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.integer :eno
      t.string :surveyid
      t.text :surveyname
      t.string :surveytype
      t.string :datatypes
      t.string :uno
      t.string :operator
      t.string :contractor
      t.string :processor
      t.string :client
      t.string :owner
      t.string :legislation
      t.string :countryid
      t.string :state
      t.string :proj_leader
      t.string :on_off
      t.date :startdate
      t.date :enddate
      t.string :vessel_type
      t.integer :spacemin
      t.integer :spacemax
      t.string :locmethod
      t.integer :accuracy
      t.string :geodetic_datum
      t.string :projection
      t.string :access_code
      t.string :qa_code
      t.date :releasedate
      t.text :comments
      t.date :entrydate
      t.string :enteredby
      t.date :lastupdate
      t.string :updatedby
      t.string :data_activity_code
      t.decimal :nlat
      t.decimal :slat
      t.decimal :elong
      t.decimal :wlong
      t.integer :ano
      t.string :qaby
      t.date :qadate
      t.date :confid_until

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
