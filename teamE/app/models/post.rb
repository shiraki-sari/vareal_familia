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
  validates :title, :genre, presence: true

  has_one_attached :picture
  belongs_to :user, optional: true

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
end
