class Organisation < ApplicationRecord
  include Speakable, Countryable, Venueable, Stageable, Contactable

  extend Enumerize
  enumerize :eduroam_type, in: [:idp, :sp, :idp_sp]

  has_many :federations, dependent: :restrict_with_exception, foreign_key: :operator_id
  belongs_to :federation, touch: true
  
  has_many :realms, dependent: :restrict_with_exception
  has_many :locations, dependent: :restrict_with_exception
  has_many :equipments, through: :locations

  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
  validates_associated :address

  has_many :radius_servers, as: :radiusable, dependent: :destroy
  accepts_nested_attributes_for :radius_servers, allow_destroy: true
  validates_associated :radius_servers

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, :domain_name, :country_code, :eduroam_type, :stage, :info_url, :policy_url, :language, presence: true
  validates :country_code, length: { is: 2 }
  validates :domain_name, format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/,
    message: "only allows letters" }

  delegate :name, to: :federation, prefix: true
  delegate :tld, to: :federation
  delegate :confederation, to: :federation

  def safe_name
    name.downcase.tr(" ", "_")
  end

  def is_an_operator?
    self == self.federation.operator
  end

end
