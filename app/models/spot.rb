class Spot < ApplicationRecord
  validates :store_name, presence: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 65_535 }
  validates :address, length: { maximum: 255 }
  validates :site_url, length: { maximum: 255 }

  belongs_to :plan
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "id", "id_value", "introduction", "plan_id", "site_url", "store_name", "updated_at"]
  end
end
