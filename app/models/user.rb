class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :plans, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_plans, through: :bookmarks, source: :plan
  has_one :profile_image, dependent: :destroy
  accepts_nested_attributes_for :profile_image

  def own?(object)
    object&. user_id == id
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
end
