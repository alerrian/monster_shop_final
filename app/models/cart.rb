class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      grand_total += subtotal_of(item_id)
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    item = Item.find(item_id)
    discount = get_discount(item, item_id).compact.first

    if !(discount.nil?)
      (count_of(item_id) * item.price) - ((count_of(item_id) * item.price)*(discount.percentage_off.to_f/100))
    else
      count_of(item_id) * item.price
    end
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def get_discount(item, item_id)
    discounts = item.merchant.discounts.order(item_threshold: :desc).map do |discount|
      if @contents[item_id.to_s] >= discount.item_threshold
        discount
      end
    end
  end
end
