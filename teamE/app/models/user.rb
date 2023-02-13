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

  validates :name, presence: true
  validates :login_id, presence: true, uniqueness: true, length: {maximum: 30}
  has_secure_password(validations: false)
  validates :password, format: { with: /[a-zA-Z0-9]/ }, on: :create
end
