module Api
  class ArticlesByAuthorQuery
    def self.call(author:)
      sql = <<~ENDSQL
        SELECT
          a.id,
          a.title,
          a.author,
          a.description,
          a.page,
          a.archive_page,
          i.id AS issue_id,
          TO_CHAR(
            TO_DATE (i.month::text, 'MM'), 'Month'
          ) AS month,
          i.year,
          i.sequence,
          m.name AS magazine_name,
          m.slug AS magazine_slug
        FROM
          articles a
        INNER JOIN
          issues i ON (i.id = a.issue_id)
        INNER JOIN
          magazines m ON (m.id = i.magazine_id)
        WHERE
          a.author ILIKE '%#{author}%'
        ORDER BY
          i.year ASC, i.month ASC;
      ENDSQL

      result = ActiveRecord::Base.connection.execute(sql)
    end
  end
end
