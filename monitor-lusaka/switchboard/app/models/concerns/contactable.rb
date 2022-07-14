module Contactable
  extend ActiveSupport::Concern

  included do
    has_many :contacts, as: :contactable, dependent: :destroy
    accepts_nested_attributes_for :contacts, allow_destroy: true
    validates_associated :contacts
  end    
end