class MagazinesController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :alpha_guide
    direction = params[:direction] || :asc

    @magazines =
      Magazine.accessible_by(current_ability)
              .search(params.slice(:name_contains))
              .order(sort => direction)
  end
end
