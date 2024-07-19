class TopsController < ApplicationController
  def top
    @new_plans = Plan.includes(:user).order(created_at: :desc).limit(4)
    @plans = Plan.includes(:user).order("RANDOM()").limit(10)
  end
end
