class User < ApplicationRecord
  paginates_per 5

  before_destroy :last_admin
  before_update :last_admin, if: :admin_changed?
  # before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :update, if: :password_digest_changed?

  private

  def last_admin
    throw(:abort) if User.where(admin:true).where.not(id: self.id).count == 0
  end
end