class Confederation < ApplicationRecord

  belongs_to :operator, class_name: "Organisation", optional: true
  has_many :federations

  has_many :radius_servers, as: :radiusable, dependent: :destroy
  accepts_nested_attributes_for :radius_servers, allow_destroy: true
  validates_associated :radius_servers

  validates :name, :email, presence: true

end
