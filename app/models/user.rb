class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[line]

  has_many :plans, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_plans, through: :bookmarks, source: :plan
  has_one :profile_image, dependent: :destroy
  accepts_nested_attributes_for :profile_image

  def own?(object)
    object&.user_id == id
  end

  # ブックマークを作る
  def bookmark(plan)
    bookmark_plans << plan
  end

  def unbookmark(plan)
    bookmark_plans.destroy(plan)
  end

  def bookmark?(plan)
    bookmark_plans.include?(plan)
  end

  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
    credentials = omniauth['credentials']
    info = omniauth['info']

    access_token = credentials['refresh_token']
    access_secret = credentials['secret']
    credentials = credentials.to_json
    name = info['name']
  end
  # def set_values_by_raw_info(raw_info)
  #   self.raw_info = raw_info.to_json
  #   self.save!
  # end
end
