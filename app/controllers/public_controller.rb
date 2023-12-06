class PublicController < ApplicationController
  skip_before_action :authenticate_user!

  def search
    sort = params[:sort] || :id
    direction = params[:direction] || :asc

    @pagy, @articles =
      pagy(
        Article.accessible_by(current_ability)
               .search(
                 params.slice(
                   :author_contains,
                   :by_article_type,
                   :by_language,
                   :by_magazine_id,
                   :by_year,
                   :for_machine,
                   :has_all_tags,
                   :has_text
                 )
               )
               .order(sort => direction),
        items: 12
      )
  end

  def status
    @magazines = Magazine.all.order(alpha_guide: :asc)
    @article_count = Article.count

    respond_to do |format|
      format.html { render layout: true }
      format.json { render json: @article_count, layout: false }
    end
  end
end
