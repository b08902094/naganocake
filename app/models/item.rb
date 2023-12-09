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

  def self.looks(search, keyword)
    if search == "perfect_match"
      @item = Item.where("name = ?", keyword)
    elsif search == "forward_match"
      @item = Item.where("name LIKE?","#{keyword}%")
    elsif search == "backward_match"
      @item = Item.where("name LIKE?","%#{keyword}")
    elsif search == "partial_match"
      @item = Item.where("name LIKE?","%#{keyword}%")
    else
      @item = Item.all
    end
  end
end