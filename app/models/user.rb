class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  before_validation { email.downcase! }
  before_destroy :admin_exist_check
  before_update :admin_update_exist

  has_secure_password

  has_many :tasks, dependent: :destroy

  def admin_exist_check
    if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end

  def admin_update_exist
    if User.where(admin: true).count == 1 && self.admin == false
      throw(:abort)
    end
  end
end
