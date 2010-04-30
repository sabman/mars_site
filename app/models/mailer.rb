class Mailer < ActionMailer::Base
  def test
    from "MARS Site <marine.samples@gmail.com>"
    recipients ["shoaib.burq@ga.gov.au"]
    subject "working?"
    body "sending from rails"
  end
end
