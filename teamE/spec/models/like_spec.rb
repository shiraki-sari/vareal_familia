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
require 'rails_helper'

RSpec.describe Like, type: :model do
  # ダミーデータを定義
  let(:user) { create(:user, :skip_validate) }
  let(:post) { create(:post) }
  
  describe 'モデルがユーザーと投稿に所属していること' do 
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'バリデーション' do
    # いいねを新規登録（DBレコード追加）
    let!(:like) { create(:like, user: user, post: post) }

    it 'いいねを新規登録できること' do
      # このいいねは、有効なデータであること
      expect(like).to be_valid
    end

    it 'ユーザーが同じ投稿にいいねを複数登録できないこと（複合ユニークチェック）' do
      new_like = build(:like, user: user, post: post)
      # このいいねは、無効なデータであること
      expect(new_like).not_to be_valid
      # すでに登録済みの同一データが存在すること
      expect(new_like.errors[:post_id]).to include('はすでに存在します')
    end
  end
end
