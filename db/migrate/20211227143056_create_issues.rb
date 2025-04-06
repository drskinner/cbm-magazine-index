class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.references :magazine, null: false
      t.integer    :year, null: false
      t.integer    :month
      t.integer    :volume
      t.integer    :number
      t.integer    :sequence
      t.string     :special

      t.timestamps
    end
  end
end
