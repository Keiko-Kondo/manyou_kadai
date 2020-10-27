class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  before_destroy :must_not_destroy_last_one

  private

  def must_not_destroy_last_one
    if User.where(admin: true).count == 1 && self.admin
    # if User.where(admin: true).count <= 1 || self.admin
      # unless User.where(admin: true).count > 1 && self.admin
      errors.add(:base, '少なくとも1人、管理者が必要です')
      # errors.add :base, '少なくとも1人、管理者が必要です'
      # return false　ではなく throw :abort
      throw :abort
    end
  end
end
