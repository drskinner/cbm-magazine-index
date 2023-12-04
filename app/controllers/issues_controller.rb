class IssuesController < ApplicationController
  load_and_authorize_resource

  def index
    sort = params[:sort] || :id
    direction = params[:direction] || :asc

    @issues =
      Issue.accessible_by(current_ability)
        .eager_load(:magazine)
        .search(params.slice(:by_magazine_id, :by_year))
        .order(sort => direction)
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to @issue
    else
      render 'new'
    end
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])

    if @issue.update(issue_params)
      redirect_to @issue
    else
      render 'edit'
    end
  end

  def issue_params
    params.require(:issue).permit(:magazine_id,
                                  :year,
                                  :month,
                                  :volume,
                                  :number,
                                  :sequence,
                                  :special)
  end
end
