class Newfeature
  def self.latest
  end

  def self.all
  {
     "2010-05-19 12:25 +10UTC" => {
      :title => "We love to login using our emails!",
      :url => nil,
      :description => <<-EOL
        If you are like the rest of us there are mornings when you 
        struggle to remember your GA user id - you know the one with 
        u + 5digits. Well we have fixed that for you - we now allow 
        login using your email address and password. Just go to 
        the <a href="/login">login page</a> and give it a try. 
      EOL
    },

     "2010-05-12 20:35 +10UTC" => {
      :title => "Give us feedback",
      :url => nil , 
      :description => <<-EOL
        You can now get in touch with the MARS team that builds this website. 
        Just click on the contact us link and with your feedback and we will 
        get in touch. You know you want to tell us something! 
        Here is the contact <a class= "thickbox" href="/emails/new?keepThis=true&TB_iframe=true&height=600&width=800">form</a>.
      EOL
    },

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
