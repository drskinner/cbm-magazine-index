class AddSearchVectorToArticles < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      ALTER TABLE articles ADD COLUMN search_vector tsvector
      GENERATED ALWAYS AS (
        setweight(to_tsvector('english', COALESCE(description, '')), 'A') ||
        setweight(to_tsvector('english', COALESCE(title, '')), 'B') ||
        setweight(to_tsvector('english', COALESCE(blurb, '')), 'C') ||
        setweight(to_tsvector('english', COALESCE(author, '')), 'D')
      ) STORED;

      CREATE INDEX articles_search_idx ON articles USING gin(search_vector);
    SQL
  end

  def down
    execute <<-SQL
      DROP INDEX articles_search_idx;
      ALTER TABLE articles DROP COLUMN search_vector;
    SQL
  end
end
