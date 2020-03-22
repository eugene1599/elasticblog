class CreateArticlesPublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :articles_publishers do |t|
      t.references :article, null: false, foreign_key: true, index: true
      t.references :publisher, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
