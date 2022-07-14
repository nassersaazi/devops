class Location < ApplicationRecord
  include Stageable, Venueable, Contactable

  extend Enumerize
  enumerize :transmission, in: {single: 0, area: 1, mobile: 2}, default: 0
  enumerize :wpa_mode, in: [:wpa, :wpa2, :both], default: :wpa2
  enumerize :encryption_mode, in: [:tkip, :aes, :both], default: :aes
  enumerize :availability, in: {always: 0, restricted: 1}, default: 0

  belongs_to :organisation

  has_many :equipments, dependent: :restrict_with_exception  

  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
  validates_associated :address

  validates :name, presence: true
  validates :wired_no, numericality: { only_integer: true, greater_than: 0 }
  validates :ap_no, numericality: { only_integer: true, greater_than: 0 }

  delegate :country_code, to: :organisation

  def enc_level
    result = Array.new
    result.push("wpa/aes") if wpa_mode.in?(["wpa","both"]) && encryption_mode.in?(["aes","both"])
    result.push("wpa/tkip") if wpa_mode.in?(["wpa","both"]) && encryption_mode.in?(["tkip","both"])
    result.push("wpa2/aes") if wpa_mode.in?(["wpa2","both"]) && encryption_mode.in?(["aes","both"])
    result.push("wpa2/tkip") if wpa_mode.in?(["wpa2","both"]) && encryption_mode.in?(["tkip","both"])
    result.join(",")
  end

  def tag
    enabled_options = {
      "port_restrict" => port_restrict, 
      "transp_proxy" => transp_proxy,
      "IPv6" => ipv6,
      "NAT" => nat,
      "HS2.0" => hs20
    }.select {|k,v| v == true}
    enabled_options.keys.join(",")
  end

end
