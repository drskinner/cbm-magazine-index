class PublicController < ApplicationController
  # skip_before_action :authenticate_user!

  def status
    @magazines = Magazine.all.order(alpha_guide: :asc)
    @article_count = Article.count

    respond_to do |format|
      format.html { render layout: true }
      format.json { render json: @article_count, layout: false }
    end
  end
end
