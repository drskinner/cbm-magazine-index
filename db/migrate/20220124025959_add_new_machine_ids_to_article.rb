class AddNewMachineIdsToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :new_machine_ids, :integer, array: true, default: []
  end
end
