class AddArchivePageOffsetToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :archive_page_offset, :integer, default: 0, null: false
  end
end
