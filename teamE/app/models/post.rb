# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
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

  validates :title, presence: true
  validate :picture_count_check

  has_many_attached :pictures
  belongs_to :user, optional: true

  private
  def picture_count_check
    errors.add(:pictures, '画像は５枚までしか登録できません') if pictures.count > MAX_PICTURE_COUNT
  end
end
