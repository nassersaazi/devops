require 'test_helper'

class EquipmentMailerTest < ActionMailer::TestCase

  test "send correct mail to IdP manager when new equipment is created" do
    organisation = organisations(:ua)
    equipment = equipment(:corridor)
    email = EquipmentMailer.with(equipment: equipment, organisation: organisation, action: 'created').institutional

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['eduroam@ren.africa'], email.from
    assert_equal organisation.users.pluck(:email), email.to
    assert_equal "[eduroam Switchboard] Equipment '#{equipment.name}' at #{equipment.location.name} just got created", email.subject
    assert_equal read_fixture('equipment_create_institutional').join, email.body.to_s    
  end

end
