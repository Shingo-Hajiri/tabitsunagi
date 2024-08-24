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
      create_failed_save
    end
  end

  def edit
    @plan = current_user.plans.find(params[:id])
    @spots = @plan.spots.order(:id)
  end

  def update
    @plan = current_user.plans.find(params[:id])

    spots_attributes = params[:plan][:spots_attributes]

    spots_attributes.each do |key, spot_params|
      if spot_params[:id].present?
        spot = @plan.spots.find_by(id: spot_params[:id])
        delete_spot_if_nil(spots_attributes, key) if spot.nil?
      end
    end

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

  def spots_map
    @spots = Spot.includes(:plan)
  end

  def bookmarks
    @bookmark_plans = current_user.bookmark_plans.includes(:user).order(created_at: :desc)
  end

  private

  def plan_params
    params.require(:plan).permit(
      :title, :body, :thumbnail,
      spots_attributes: %i[id store_name introduction address site_url image opening_hours phone_number _destroy]
    )
  end

  def create_failed_save
    @plan.spots.build if @plan.spots.empty?
    flash.now[:alert] = t('.failure')
    render :new, status: :unprocessable_entity
  end

  def delete_spot_if_nil(spots_attributes, key)
    spots_attributes.delete(key)
  end
end
