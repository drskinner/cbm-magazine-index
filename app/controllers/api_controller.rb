class ApiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :validate_token
  
  def bibliography
    @foo = Api::ArticlesByAuthor.call(author: params[:author])

    respond_to do |format|
      format.json { render json: @foo, layout: false }
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
