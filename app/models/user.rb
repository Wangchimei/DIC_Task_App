class User < ApplicationRecord
  before_destroy :last_admin
  has_many :tasks, dependent: :destroy
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :update, if: :password_digest_changed?

  private

  def last_admin
    throw(:abort) if User.where(admin: true).count <= 1
  end
end