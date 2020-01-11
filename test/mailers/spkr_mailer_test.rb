require 'test_helper'

class SpkrMailerTest < ActionMailer::TestCase
  test "edited_spkr" do
    mail = SpkrMailer.edited_spkr
    assert_equal "Edited spkr", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
