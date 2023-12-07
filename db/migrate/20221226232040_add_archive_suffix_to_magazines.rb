class AddArchiveSuffixToMagazines < ActiveRecord::Migration[6.1]
  def change
    add_column :magazines, :archive_suffix, :string, default: nil
  end    
end
