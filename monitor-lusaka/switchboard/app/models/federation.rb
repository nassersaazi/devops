class Federation < ApplicationRecord
  include Speakable, Countryable

  extend Enumerize
  enumerize :stage, in: {test: 0, productive: 1}, default: 1

  belongs_to :confederation
  belongs_to :operator, class_name: "Organisation" #, optional: true
  has_many :organisations
  has_many :contacts, through: :operator
  has_many :radius_servers, as: :radiusable, dependent: :destroy
  accepts_nested_attributes_for :radius_servers, allow_destroy: true
  validates_associated :radius_servers

  validates :tld, :email, :stage, :info_url, :policy_url, :language, :identifier, :operator,  presence: true
  validates :tld, length: { is: 2 }
  validates :tld, uniqueness: true
  validates :info_url, :policy_url, url: true

  def name
    ".#{tld.downcase} Federation operated by #{operator&.name}"
  end

end
