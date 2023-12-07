class ChangeColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :new_tag_ids, :tag_ids
    rename_column :articles, :new_machine_ids, :machine_ids
  end
end
