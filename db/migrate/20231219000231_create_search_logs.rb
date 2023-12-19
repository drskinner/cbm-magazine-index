class CreateSearchLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :search_logs do |t|
      t.json    :search_terms
      t.integer :result_count

      t.timestamps
    end
  end
end
