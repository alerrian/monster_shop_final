class Discount < ApplicationRecord
  validates_presence_of :name,
                        :item_threshold,
                        :percentage_off
  belongs_to :merchant
end
