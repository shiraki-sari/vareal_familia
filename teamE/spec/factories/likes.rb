# == Schema Information
#
# Table name: likes
#
#  id(ID)              :bigint           unsigned, not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  post_id(投稿ID)     :bigint           not null
#  user_id(ユーザーID) :bigint           not null
#
# Indexes
#
#  index_likes_on_post_id  (post_id)
#  index_likes_on_user_id  (user_id)
#  post_id                 (post_id,user_id) UNIQUE
#  user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :like do
    user
    post
  end
end
