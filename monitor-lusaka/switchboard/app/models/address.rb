class Address < ApplicationRecord
  include Coordinateable, Countryable

  belongs_to :addressable, polymorphic: true, optional: true

  validates :street, :city, :country_code, presence: true

  geocoded_by :full_street_address
  # after_validation :geocode, if: ->(obj){ obj.changed? }
  after_validation :geocode#, if: ->(obj){ obj.full_street_address.present? and obj.changed? }

  def full_street_address
    [street, street2, zip, city, state, country_code].compact.join(', ')
  end

end
