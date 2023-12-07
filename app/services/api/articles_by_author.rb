module Api
  class ArticlesByAuthor < ApplicationService
    def call
      Api::ArticlesByAuthorQuery.call(author: author)
    end

    private

    def author
      @options[:author]
    end
  end
end
