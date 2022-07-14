require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  test "Mandatory attributes must not be empty" do
    contact = Contact.new
    assert contact.invalid?,            "Incomplete Contact is valid"
    assert contact.errors[:name].any?,  "Missing name doesn't show error"
    assert contact.errors[:email].any?, "Missing email doesn't show error"
    assert contact.errors[:phone].any?, "Missing phone doesn't show error"
  end

  test "Contact Type only accepts single integer" do
    contact = Contact.new(contact_type: 21)
    assert contact.invalid?
    assert contact.errors[:contact_type].any?
  end

  test "Privacy only accepts single integer" do
    contact = Contact.new(privacy: 21)
    assert contact.invalid?
    assert contact.errors[:privacy].any?
  end

end
