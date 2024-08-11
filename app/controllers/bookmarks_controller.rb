class BookmarksController < ApplicationController
  def create
    @plan = Plan.find(params[:plan_id])
    current_user.bookmark(@plan)
  end

  def destroy
    @plan = current_user.bookmarks.find(params[:id]).plan
    current_user.unbookmark(@plan)
  end
end
