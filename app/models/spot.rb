class Spot < ApplicationRecord
  validates :store_name, presence: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 65_535 }
  validates :address, length: { maximum: 255 }
  validates :site_url, length: { maximum: 255 }

  belongs_to :plan
end
