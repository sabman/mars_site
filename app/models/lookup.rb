class Lookup < ActiveRecord::Base
  set_table_name :lookups
  set_inheritance_column nil

  @@operators, @@survey_platforms = nil


  def self.survey_platforms
    @@survey_platforms ||= self.find_by_sql("select * from lookups where type = 'SURVEY PLATFORM' order by value ASC").collect{|r| 
      name = r.code.nil? || r.code == '__' ? r.value : r.value + " (#{r.code})"
      value = r.value
      [name, value]
    }
  end

  def self.accuricies
    @@accuricies ||= self.find_by_sql("select * from locmethods order by locmethno ASC").collect{|r| 
      name = r.accuracy.nil? ? r.locmethod : r.locmethod + " (+/-" + r.accuracy.to_s + "m)" 
      value = r.accuracy.to_s
      [name, value]
    }
  end

  def self.location_methods
    @@location_methods ||= self.find_by_sql("select * from locmethods order by locmethno ASC").collect{|r| 
      name = r.accuracy.nil? ? r.locmethod : r.locmethod + " (+/-" + r.accuracy.to_s + "m)" 
      value = r.locmethod
      [name, value]
    }
  end
  def self.ports
    @@ports ||= self.find_by_sql("select * from ports order by countryid, port ASC").collect{|r| r.port + (", " + r.countryid if !r.countryid.nil?).to_s  }
  end

  def self.survey_types
    self.find_by_sql("select value from a.lookups where type = 'SURVEY TYPE' order by value ASC").collect{|r| r.value}
  end

  def self.operators
     @@operators ||= self.find_by_sql("select * from companies order by company ASC").collect{|c| c.acronym.nil? ? [ c.company , c.company] : [ "#{c.acronym} -- #{c.company}", c.company] }
  end

  def self.auto_complete_for_operators(query)
    self.find_by_sql("select * from companies where company like \'%#{query}%\' or acronym like \'%#{query}%\'").collect{|c|c.company}
  end

  def self.states
    @@states ||= self.find_by_sql("select * from states order by stateid ASC").collect{|c| ["#{c.stateid} -- #{c.statename}" , c.stateid] }
  end

  def self.orginators
  end

  def self.countries
    @@countries ||= self.find_by_sql("select * from countries order by countryid ASC").collect{|c| ["#{c.countryid} -- #{c.countryname}" , c.countryid] }
  end

  def self.find_country_by_countryid(countryid)
    self.find_by_sql("select * from countries where countryid = \'#{countryid}\'").try(:first)
  end

  def self.find_country_by_countryno(countryno)
    self.find_by_sql("select * from countries where countryno = #{countryno}").try(:first)
  end

  def self.find_country_by_countryname(countryname)
    self.find_by_sql("select * from countries where countryname = #{countryname}").try(:first)
  end
end
