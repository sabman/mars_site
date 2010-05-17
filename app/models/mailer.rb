class Mailer < ActionMailer::Base
  def test
    from "MARS Site <marine.samples@gmail.com>"
    recipients ["shoaib.burq@ga.gov.au"]
    subject "working?"
    body "sending from rails"
  end

  def feedback(o={})
    o.reverse_merge!( :sender => "marine.samples@gmail.com", :cc => "saburq@gmail.com", :subject => "feedback" )
    from o[:sender]
    cc o[:cc]
    bcc o[:bcc]
    recipients [YAML.load_file(RAILS_ROOT+"/config/data_managers.yml")["email"]]
    subject o[:subject]
    body <<-EOL
#{o[:body]}  
Tags: #{o[:tags]}
Referer: #{o[:referer]}
EOL
  end
end
