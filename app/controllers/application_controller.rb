class ApplicationController < ActionController::Base
  before_action :set_search
  def not_authenticated
    redirect_to login_path
  end

  def set_search
    @q = Plan.ransack(params[:q])
    @search_plans = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end
end
