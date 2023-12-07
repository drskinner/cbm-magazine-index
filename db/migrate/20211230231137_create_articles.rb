class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string     :title, null: false
      t.string     :author, null: false
      t.integer    :page      
      t.references :issue, null: false
      t.references :classification, null: false
      t.references :language
      t.text       :blurb
      t.text       :description, null: false

      t.timestamps
    end
  end
end
