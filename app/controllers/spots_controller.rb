class SpotsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy!
  end
end
