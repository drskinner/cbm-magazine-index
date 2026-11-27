class ApiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :validate_token
  
  def bibliography
    @foo = Api::ArticlesByAuthor.call(author: params[:author])

    respond_to do |format|
      format.json { render json: @foo, layout: false }
    end
  end

  def search
    @articles = Article.search(has_text: params[:q])
                      .includes(issue: :magazine)
                      .limit(5)
                      .map do |a|
      {
        title: a.title,
        author: a.author,
        magazine: a.issue.magazine.to_s,
        magazine_slug: a.issue.magazine.slug,
        date: a.issue.date_display,
        page: a.page
      }
    end

    respond_to do |format|
      format.json { render json: @articles, layout: true }
    end
  end

  def status_counts
    @counts = { articles: Article.count, issues: Issue.count }

    respond_to do |format|
      format.json { render json: @counts, layout: false }
    end
  end

  def validate_token
    redirect_to root_path unless valid_token?
  end
  
  def valid_token?
    ApiKeys.enabled.where(access_token: params[:token]).exists?
  end
end
