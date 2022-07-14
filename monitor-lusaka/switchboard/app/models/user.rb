class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable, 
          :timeoutable, :recoverable, :rememberable, 
          :trackable, :validatable, :confirmable

  has_many :memberships, dependent: :destroy
  accepts_nested_attributes_for :memberships, allow_destroy: true
  validates_associated :memberships
  
  has_many :organisations, through: :memberships
  

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_member_or_operator?(radiusable)
    if radiusable.is_a? Organisation
      is_member?(radiusable) or operated_organisations.include? radiusable
    elsif radiusable.is_a? Federation
      is_operator?(radiusable)
    else
      false
    end
  end

  def is_an_operator?
    operated_organisations.exists?
  end

  def is_a_member?
    organisations.exists?
  end

  def is_operator?(federation)
    organisations.where('memberships.operator = true').include? federation.operator
  end

  def is_member?(organisation)
    organisations.include? organisation
  end

  def operated_organisations
    Organisation.where(federation_id: operated_federations.ids)
    # Organisation.where("federation_id = ?", operated_federations.ids)
  end

  def operated_federations
    Federation.where(operator_id: organisations.ids)
    # Federation.where("operator_id = ?", organisations.ids)
  end

end
