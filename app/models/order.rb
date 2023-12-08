class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details
    has_many :items, through: :order_details
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum status: {waiting_for_payment: 0, payment_confirmed: 1, in_progress: 2, shipping_prep: 3, shipped: 4}
end
