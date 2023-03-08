# == Schema Information
#
# Table name: genres
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_genres_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| "ジャンル#{n}" }
  end
end
