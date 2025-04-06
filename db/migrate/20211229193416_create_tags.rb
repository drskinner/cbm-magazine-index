class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string   :name, null: false
      t.string   :alpha_guide, null: false

      t.timestamps
    end
  end
end
