class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :set_csp_nonce
  def not_authenticated
    redirect_to new_user_session_path
  end

  def set_search
    @q = Plan.ransack(params[:q])
    # @search_plans = @q.result(distinct: true).includes(:user).order(created_at: :desc)
    return unless search_keywords_present?

    @search_plans = Plan.ransack(search_params).result(distinct: true).includes(:user).order(created_at: :desc)
  end

  private

  def search_keywords_present?
    params[:q].present? && params[:q][:title_or_body_or_spots_store_name_or_spots_address_cont].present?
  end

  def search_params
    key_words = params[:q][:title_or_body_or_spots_store_name_or_spots_address_cont].split(/[\p{blank}\s]+/)
    grouping_hash = key_words.reduce({}) do |hash, word|
      hash.merge(word => { title_or_body_or_spots_store_name_or_spots_address_cont: word })
    end
    { combinator: 'and', groupings: grouping_hash }
  end

  def set_csp_nonce
    # CSP nonce を生成
    @csp_nonce = SecureRandom.base64(16)
  end
end
