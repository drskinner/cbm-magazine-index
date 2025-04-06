class CreateMachines < ActiveRecord::Migration[6.1]
  def change
    create_table :machines do |t|
      t.string   :name, null: false
      t.integer  :position, null: false

      t.timestamps
    end
  end
end
