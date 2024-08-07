class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one :map, dependent: :destroy
  validates :category, presence: true
  scope :with_star, ->(star) { where('star >= ?', star) if star.present? }
  geocoded_by :address
  after_validation :geocode
  validates :image, presence: true
  validates :sentence, presence: true
  validates :category, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
