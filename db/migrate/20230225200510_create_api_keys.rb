class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.string  :name, null: false
      t.string  :access_token, null: false
      t.boolean :enabled, default: false
      
      t.timestamps
    end
  end
end
