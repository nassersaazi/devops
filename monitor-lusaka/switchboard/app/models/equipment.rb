class Equipment < ApplicationRecord
  include Secretable, Notifiable
  extend Enumerize
  enumerize :nas_type, in: [:cisco, :computone, :livingston, :max40xx, :multitech, :netserver, :pathras, :patton, :portslave, :tc, :usrhiper, :other], default: :other
  enumerize :nas_kind, in: [:ap, :switch, :other], default: :ap

  belongs_to :location
  
  delegate :organisation, to: :location, allow_nil: true

  before_create :generate_secrets
  
  after_create :notify_about_new_equipment
  after_update :notify_about_updated_equipment
  after_destroy :notify_about_deleted_equipment

end
