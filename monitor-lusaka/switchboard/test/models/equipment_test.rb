require 'test_helper'

class EquipmentTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "notify IdP managers about new equipment" do
    equipment = equipment(:corridor)
    assert_enqueued_emails 1 do
      Equipment.create(ip4: equipment.ip4, ip6: equipment.ip6, location_id: equipment.location_id, mac: equipment.mac, name: equipment.name, nas_type: equipment.nas_type, prefix4: equipment.prefix4, prefix6: equipment.prefix6, protocol: equipment.protocol, require_message_authenticator: equipment.require_message_authenticator, switchboard_secret: equipment.switchboard_secret, upstream_secret: equipment.upstream_secret)
    end
  end

  test "notify IdP managers about updated equipment" do
    equipment = equipment(:corridor)
    assert_enqueued_emails 1 do
      equipment.update(ip4: '1.2.3.4')
    end
  end

  test "notify IdP managers about deleted equipment" do
    equipment = equipment(:corridor)
    assert_emails 1 do
      equipment.destroy
    end
  end

end
