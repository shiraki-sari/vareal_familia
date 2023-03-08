# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genres = %w(和食 カレー ラーメン 居酒屋 焼肉 カフェ パン 韓国料理 中華 イタリアン フレンチ)
genres.each { |genre| Genre.find_or_create_by!(name: genre) }
