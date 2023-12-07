class AddNewTagIdsToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :new_tag_ids, :integer, array: true, default: []
  end
end
