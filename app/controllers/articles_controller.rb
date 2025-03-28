class ArticlesController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :id
    direction = params[:direction] || :asc

    @pagy, @articles =
      pagy(
        Article
          .accessible_by(current_ability)
          .search(params.slice(:by_magazine_id, :by_sequence, :by_year))
          .order(sort => direction)
      )
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article)
          .permit(
            :archive_page,
            :author,
            :blurb,
            :classification_id,
            :description,
            :issue_id,
            :language_id,
            :page,
            :regular_feature,
            :title,
            machine_ids: [],
            tag_ids: []
          )
  end
end
