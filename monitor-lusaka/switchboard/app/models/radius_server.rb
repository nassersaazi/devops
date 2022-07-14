class RadiusServer < ApplicationRecord
  include Secretable, Notifiable
  extend Enumerize
  enumerize :server_type, in: [:idp, :sp, :idp_sp, :fp, :rp, :tlr, :monitor, :switchboard]
  enumerize :product, in: [:fr3, :fr2, :radsecproxy, :radiator, :other], default: :fr3
  enumerize :protocol, in: [:udp, :tcp, :both], default: :udp

  belongs_to :radiusable, polymorphic: true, optional: true

  validates :name, :server_type, :protocol, :require_message_authenticator, :auth, :auth_port, presence: true
  validates :ip4, format: { with: Resolv::IPv4::Regex, message: "Not a valid IPv4 format"}, allow_blank: true
  validates :ip6, format: { with: Resolv::IPv6::Regex, message: "Not a valid IPv6 format"}, allow_blank: true
  validates :mac, mac: true, allow_blank: true
  validate :either_ip4_or_ip6_provided, :either_auth_or_acct_selected

  before_create :generate_secrets

  after_create :notify_about_new_radius_server
  after_update :notify_about_updated_radius_server
  after_destroy :notify_about_deleted_radius_server

  scope :type, -> (t) { where(server_type: t) }

  def safe_name
    name.downcase.tr(" ", "_")
  end

  def safe_ip_name(ip)
    if ip == ip4
      safe_ip4_name
    elsif ip == ip6
      safe_ip6_name
    end
  end

  def safe_ip4_name
    safe_name.concat(".ip4")
  end

  def safe_ip6_name
    safe_name.concat(".ip6")
  end

  def either_auth_or_acct_selected
    unless auth or acct
      errors.add(:auth)
      errors.add(:acct)
      errors[:base] << "Select either Auth, Acct or both"
    end
  end
 
  def either_ip4_or_ip6_provided
    if ip4.blank? and ip6.blank?
      errors.add(:ip4)
      errors.add(:ip6)
      errors[:base] << "Provide either IPv4 or IPv6 address"
    end
  end


  def auth_acct
    if self.auth
      if self.acct
        { type: "auth+acct", ports: "#{auth_port},#{acct_port}", pool: "pool" } 
      else
        { type: "auth", ports: "#{auth_port}", pool: "auth_pool" } 
      end
    elsif self.acct
      { type: "acct", ports: "#{acct_port}", pool: "acct_pool" } 
    else
      { type: "", ports: "", pool: "" }
    end
  end

  def upstream_servers
    if self.radiusable_type == "Organisation"
      self.radiusable.federation.radius_servers
    elsif self.radiusable_type == "Federation"
      RadiusServer.type(:rp)
    elsif self.radiusable_type == "Confederation"
      RadiusServer.type(:tlr)
    else
      nil
    end
  end

end
