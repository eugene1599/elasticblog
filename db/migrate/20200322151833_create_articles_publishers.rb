class CreateArticlesPublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :articles_publishers, id: false do |t|
      t.references :article
      t.references :publisher
    end
  end
end
