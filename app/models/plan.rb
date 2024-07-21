class Plan < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  has_many :spots, dependent: :destroy
  accepts_nested_attributes_for :spots, reject_if: :all_blank, allow_destroy: true
  has_one_attached :thumbnail

  def self.ransackable_attributes(auth_object = nil)
    # 検索対象としたい属性を列挙します
    ["title", "body", "created_at", "updated_at", "user_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["spots", "thumbnail_attachment", "thumbnail_blob", "user"]
  end
end
