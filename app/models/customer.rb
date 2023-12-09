class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :lastname_kana, presence: true
  validates :firstname_kana, presence: true
  validates :email, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  def self.looks(search, keyword)
    if search == "perfect_match"
      @customer = Customer.where('lastname = ? OR firstname = ? OR lastname_kana = ? OR firstname_kana = ?',
                  keyword, keyword, keyword, keyword)
    elsif search == "forward_match"
      @customer = Customer.where('lastname LIKE ? OR firstname LIKE? OR lastname_kana LIKE? OR firstname_kana LIKE?',
                  "#{keyword}%", "#{keyword}%", "#{keyword}%", "#{keyword}%")
    elsif search == "backward_match"
      @customer = Customer.where('lastname LIKE ? OR firstname LIKE? OR lastname_kana LIKE? OR firstname_kana LIKE?',
                  "%#{keyword}", "%#{keyword}", "%#{keyword}", "%#{keyword}")
    elsif search == "partial_match"
      @customer = Customer.where('lastname LIKE ? OR firstname LIKE? OR lastname_kana LIKE? OR firstname_kana LIKE?',
                  "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    else
      @customer = Customer.all
    end
  end
end
