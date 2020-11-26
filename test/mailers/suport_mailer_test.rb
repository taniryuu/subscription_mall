require 'test_helper'

class SuportMailerTest < ActionMailer::TestCase
  test "suport_mail" do
    mail = SuportMailer.suport_mail
    assert_equal "Suport mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
