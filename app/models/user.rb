class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :recoverable, :lockable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :activated,
                  :mandator_id, :mandator_name, :role_ids

  default_scope order('email asc')

  belongs_to :mandator
  has_many :message

  has_paper_trail :ignore => [:current_sign_in_at, :last_sign_in_at,
                              :current_sign_in_ip, :last_sign_in_ip,
                              :sign_in_count, :failed_attempts]

  def mandator_name
    mandator.try(:name)
  end

  def mandator_name=(name)
    self.mandator = Mandator.find_or_create_by_name(name) if name.present?
  end

  def active_for_authentication?
    super && activated?
  end

  def inactive_message
    activated? ? :not_approved : super
  end
end
