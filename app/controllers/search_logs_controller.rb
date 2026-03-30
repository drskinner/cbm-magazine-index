class SearchLogsController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :created_at
    direction = params[:direction] || :desc

    @pagy, @search_logs =
      pagy(
        SearchLog
          .accessible_by(current_ability)
          .search(params.slice(:zero_results))
          .order(sort => direction),
        items: 25
      )
  end

  def show
    @search_log = SearchLog.find(params[:id])
  end
end
