class Newfeature
  def self.latest
  end

  def self.all
  {
    "2010-05-06 20:00 +10UTC" => {
      :title => "Raw Grain Size Data",
      :url => "/surveys/438255-TAN0713/grain_size" , 
      :description => <<-EOL
        You can now view the raw grain size data for any survey that has had its sample analysied
        For example if you go to the Tangaro Survey: <a href="/surveys/438255-TAN0713">TAN0713</a>
        you will see a link on the right for grain size data 
        <a href="/surveys/438255-TAN0713/grain_size">View Grain Size Data</a>
      EOL
    },

    "2010-05-06 13:00 +10UTC" => { 
      :title => "Users", 
      :url => "/users",
      :description => <<-EOL 
        You can now see the users that are registered and using MARS 
        by going to <a href="/users">users</a>
      EOL
    }
  }
  end
end
