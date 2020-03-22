class CreateArticlesTags < ActiveRecord::Migration[6.0]
  def change
    create_table :articles_tags do |t|
      t.references :article, null: false, foreign_key: true, index: true
      t.references :tag, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
