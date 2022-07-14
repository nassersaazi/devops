class Realm < ApplicationRecord
  include Secretable, Notifiable

  belongs_to :organisation

  before_validation :set_generic_flag
  before_create :generate_test_user
  after_create :send_new_realm_notifications
  after_update :send_updated_realm_notifications
  after_destroy :send_deleted_realm_notifications

  validates :domain_name, presence: true
  validates :domain_name, uniqueness: true
  validates :domain_name, format: { with: /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/,
    message: "only allows letters and numbers" }

  scope :generic, -> { where(generic: true) }

  protected
    def set_generic_flag
      realm_tld = domain_name.split('.').last
      if realm_tld.casecmp?(organisation.federation.tld)
        self.generic = false
      else
        self.generic = true
      end
    end

end
