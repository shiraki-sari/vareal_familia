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
require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'update blog title and contents' do
    post = FactoryBot.create(:post)
    post.update({ title: 'タイトル編集', content: '内容編集', genre: 0 })
    expect(post.title).to eq 'タイトル編集'
    expect(post.content).to eq '内容編集'
    expect(post.content).to eq 'izakaya'
  end
  #pending "add some examples to (or delete) #{__FILE__}"
end
