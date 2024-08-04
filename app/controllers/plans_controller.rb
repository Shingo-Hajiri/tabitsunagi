class PlansController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @plans = Plan.includes(:user).order(created_at: :desc)
  end

  def new
    @plan = Plan.new
    @plan.spots.build
  end

  def show
    @plan = Plan.find(params[:id])
    @spots = @plan.spots.order(:id)
  end

  def create
    @plan = current_user.plans.build(plan_params)
    if @plan.save
      redirect_to complete_plans_path, notice: t('.success')
    else
      if @plan.spots.empty?
        @plan.spots.build
      end
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plan = current_user.plans.find(params[:id])
  end

  def update
    @plan = current_user.plans.find(params[:id])
    if @plan.update(plan_params)
      redirect_to plan_path(@plan), notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plan = current_user.plans.find(params[:id])
    @plan.destroy!
    redirect_to plans_path, notice: t('.success'), status: :see_other
  end

  def complete; end

  def my_recommends
    @plans = current_user.plans.includes(:user).order(created_at: :desc)
  end

  def edit_last
    @plan = current_user.plans.order(created_at: :desc).first
    if @plan
      redirect_to edit_plan_path(@plan)
    else
      redirect_to root_path, alert: t('.failure')
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
