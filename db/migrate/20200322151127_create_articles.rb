class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :user, null: false, foreign_key: true, index: true
      t.references :category, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end