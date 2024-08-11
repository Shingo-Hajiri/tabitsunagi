class Plan < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
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

  def first_spot_address
    return '' unless spots.any?
    prefectures_processing(spots.first.address)
  end

  private

  def prefectures_processing(address)
    # オートコンプリート機能を使用しなかった場合、住所が空白になることがあるのでnilも考慮しないといけない
    return '日本' if address.nil?
    prefecture_pattern = /(東京都|北海道|(?:京都|大阪)府|.{2,3}県)/
    match = address.match(prefecture_pattern)
  end
end
