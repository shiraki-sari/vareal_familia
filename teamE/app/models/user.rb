# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  login_id        :string(30)       not null
#
class User < ApplicationRecord
  has_many :posts
  has_many :likes

  validates :name, presence: true
  validates :login_id, presence: true, uniqueness: true, length: {maximum: 30}
  has_secure_password(validations: false)

  validate do |record|
    record.errors.add(:password, :blank) if record.password_digest.blank?
  end

  validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字のみが使用できます" }
  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
  validates_confirmation_of :password, allow_blank: true

  validates :password_confirmation, presence: true
end
