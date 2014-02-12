require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #

  test  "users can be added" do
    if User.find_by_name("jon") then
      User.find_by_name("jon").destroy
    end
    User.add("jon", "wayne")
    assert User.find_by_name_and_password("jon", "wayne")
  end
  
  test "users can log in" do
    User.add("jon", "wayne")
    old_logins = User.login("jon", "wayne")[0]
    assert old_logins < User.login("jon", "wayne")[0]
  end

  test "users must have the right password" do
    assert User.login("zachary", "wrongone")[1] == -1
  end

  test "users must have usernames under 128char" do
    assert User.add("Voila! In view humble vaudevillian veteran, cast vicariously as both victim and villain by the vicissitudes of fate. This visage, no mere veneer of vanity, is a vestige of the “vox populi” now vacant, vanished. However, this valorous visitation of a bygone vexation stands vivified, and has vowed to vanquish these venal and virulent vermin, van guarding vice and vouchsafing the violently vicious and voracious violation of volition.
                    The only verdict is vengeance; a vendetta, held as a votive not in vain, for the value and veracity of such shall one day vindicate the vigilant and the virtuous.
                    Verily this vichyssoise of verbiage veers most verbose, so let me simply add that it’s my very good honour to meet you and you may call me V.", "freedom")[1] == -3
  end

  test "users must have passwords under 128char" do
    assert User.add("super_secure_elite_hacker",
                    "Hahaha! At last, one hundred and twenty eight entire UTF-8 characters of UNCRACKABLE CRYPTOGRAPHIC POWER! No one can possibly oppose my unbelievably irritatingly long password.")[1] == -4
  end
end
