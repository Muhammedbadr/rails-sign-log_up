class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
        :confirmable

  after_create :assign_default_role

  validate :must_have_at_least_one_role, on: :update

  private

  def assign_default_role
    if User.count == 1
      self.add_role(:admin)
    else
      self.add_role(:newuser) if self.roles.blank?
    end
  end 
  
  def must_have_at_least_one_role
    if roles.empty?
      errors.add(:roles, "must have at least one role")
    end
  end 
end


