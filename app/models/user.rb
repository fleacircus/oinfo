class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :lockable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :role_ids

  has_and_belongs_to_many :roles, :uniq => true

  def role?(role)
    return self.roles.find_by_name(role)
  end
end
