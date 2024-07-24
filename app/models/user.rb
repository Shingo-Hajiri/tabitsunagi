class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :plans, dependent: :destroy
  has_one :profile_image, dependent: :destroy
  accepts_nested_attributes_for :profile_image

  def own?(object)
    object&. user_id == id
  end
end
