class AddSpecialSlugToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :special_slug, :string, default: nil
  end
end
