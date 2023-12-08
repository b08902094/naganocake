class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price_before_tax, presence: true

  def get_image(*size)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      item_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end
    if !size.empty?
      item_image.variant(resize: size)
    else
      item_image.variant(resize: '300')
    end
  end

  def with_tax_price
    (price_before_tax * 1.1).floor
  end
end