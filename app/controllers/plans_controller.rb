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

  def show
    @plan = Plan.find(params[:id])
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to complete_plans_path, notice: '旅行プランを投稿しました。'
    else
      if @plan.spots.empty?
        @plan.spots.build
      end
      flash.now[:alert] = '旅行プランを投稿できませんでした。'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plan = current_user.plans.find(params[:id])
  end

  def update
    @plan = current_user.plans.find(params[:id])
    if @plan.update(plan_params)
      redirect_to plans_path, notice: '旅行プランを更新しました。'
    else
      flash.now[:alert] = '旅行プランを更新できませんでした。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plan = current_user.plans.find(params[:id])
    @plan.destroy!
    redirect_to plans_path, notice: '旅行プランを削除しました。', status: :see_other
  end

  def complete; end

  def edit_last
    @plan = current_user.plans.order(created_at: :desc).first
    if @plan
      redirect_to edit_plan_path(@plan)
    else
      redirect_to root_path, alert: "No articles found."
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
