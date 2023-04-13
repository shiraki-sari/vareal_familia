# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  genre      :integer          not null
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  MAX_PICTURE_COUNT = 5
  attribute :genre, :integer, default: 0
  validates :title, :genre, presence: true
  validate :picture_count_check

  has_many_attached :pictures
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy 
  enum genre: {
    izakaya: 0,
    teishoku: 1,
    curry: 2,
    ramen: 3,
    udon: 4,
    sushi: 5,
    yakiniku: 6,
    fastfood: 7,
    cafe: 8,
    bakery: 9,
    sweets: 10,
    korean: 11,
    chinese: 12,
    italian: 13,
    french: 14
  }

  private
  def picture_count_check
    errors.add(:pictures, '画像は５枚までしか登録できません') if pictures.count > MAX_PICTURE_COUNT
  end
end
