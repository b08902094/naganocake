class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum status: {
      discarded: 0,
      waiting_for_production: 1,
      production_in_progress: 2,
      done: 3
  }
end
