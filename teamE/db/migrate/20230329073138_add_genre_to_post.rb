class AddGenreToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :genre, :integer, null: false, after: :content
  end
end
