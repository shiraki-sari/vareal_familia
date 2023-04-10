class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table "likes", id: { type: :bigint, comment: "ID" }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "投稿×ユーザーごとのいいね履歴", force: :cascade do |t|
      t.belongs_to :post, null: false, foreign_key: true, comment: "投稿ID"
      t.belongs_to :user, null: false, foreign_key: true, comment: "ユーザーID"
      t.timestamps
      t.index ["post_id", "user_id"], name: "post_id", unique: true
      t.index ["user_id"], name: "user_id"
    end
  end
end
