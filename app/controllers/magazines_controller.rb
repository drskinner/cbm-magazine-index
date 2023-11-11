class MagazinesController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :alpha_guide
    direction = params[:direction] || :asc

    @magazines = Magazine.accessible_by(current_ability)
    @full_count = @magazines.count

    @magazines = @magazines.order(sort => direction)
    #                        .page(params[:page])
  end
end
