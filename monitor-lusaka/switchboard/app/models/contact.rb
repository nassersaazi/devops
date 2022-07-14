class Contact < ApplicationRecord
  extend Enumerize
  enumerize :contact_type, in: {person: 0, departement: 1}, default: 0
  enumerize :privacy, in: {private: 0, public: 1}, default: 0

  belongs_to :contactable, polymorphic: true, optional: true, touch: true

  validates :name, :email, :phone, :contact_type, :privacy, presence: true

end
