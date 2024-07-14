class PlansController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @plans = Plan.includes(:user).order(created_at: :desc)
  end

  def new
    @plan = Plan.new
    @plan.spots.build
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to plans_path, notice: '旅行プランを投稿しました。'
    else
      if @plan.spots.empty?
        @plan.spots.build
      end
      flash.now[:alert] = '旅行プランを投稿できませんでした。'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def plan_params
    params.require(:plan).permit(
      :title, :body, :thumbnail,
      spots_attributes: [:id, :store_name, :introduction, :address, :site_url, :image]
    )
  end
end
