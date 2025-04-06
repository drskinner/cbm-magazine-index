class AddArchivePageToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :archive_page, :string, default: nil
  end
end
