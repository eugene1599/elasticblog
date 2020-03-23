class CreateArticlesTags < ActiveRecord::Migration[6.0]
  def change
    create_table :articles_tags, id: false do |t|
      t.references :article
      t.references :tag
    end
  end
end
