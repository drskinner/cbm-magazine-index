class AddRegularFeatureToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :regular_feature, :boolean, null: false, default: false
  end
end
