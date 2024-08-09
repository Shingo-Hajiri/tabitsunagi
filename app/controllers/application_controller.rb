class ApplicationController < ActionController::Base
  before_action :set_search
  def not_authenticated
    redirect_to login_path
  end

  def set_search
    @q = Plan.ransack(params[:q])
    # @search_plans = @q.result(distinct: true).includes(:user).order(created_at: :desc)
    if params[:q].present? && params[:q][:title_or_body_or_spots_store_name_or_spots_address_cont].present?
      key_words = params[:q][:title_or_body_or_spots_store_name_or_spots_address_cont].split(/[\p{blank}\s]+/)
      grouping_hash = key_words.reduce({}) do |hash, word|
        hash.merge(word => { title_or_body_or_spots_store_name_or_spots_address_cont: word })
      end
      @search_plans = Plan.ransack({ combinator: 'and', groupings: grouping_hash }).result(distinct: true).includes(:user).order(created_at: :desc)
    end
  end
end
