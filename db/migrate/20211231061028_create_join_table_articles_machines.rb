class CreateJoinTableArticlesMachines < ActiveRecord::Migration[6.1]
  def change
    create_join_table :articles, :machines do |t|
      t.index [:article_id, :machine_id]
      t.index [:machine_id, :article_id]
    end
  end
end
