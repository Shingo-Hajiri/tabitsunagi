class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :plans, dependent: :destroy

  has_one_attached :avatar

  def own?(object)
    object&. user_id == id
  end
end
