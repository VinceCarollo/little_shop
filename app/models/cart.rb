class Cart
  attr_reader :contents

  def initialize(session)
    @contents = session || Hash.new(0)
  end

  def add(item_id)
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end

  def ids_to_items
    items = {}
    self.contents.each do |item_id, qty|
      items[Item.find(item_id)] = qty
    end
    items
  end

  def total_price
    ids_to_items.sum{|item, qty| item.price * qty}
  end

  def discounted_price(coupon_id)
    if coupon_id
      coupon = Coupon.find(coupon_id)
      total_price - coupon.amount_off
    end
  end

  def create_order(buyer_id, location=nil, coupon=nil)
    order = Order.new(user_id: buyer_id, status: 1)
    order.location = location if !location.nil?
    if coupon
      order.coupon = coupon
      discounted_item = ids_to_items.find{|item, qty| item.id = coupon.user_id}[0]
      if coupon.amount_off > discounted_item.price
        discounted_price.price = 0
      else
        discounted_item.price -= coupon.amount_off
      end
    end
    ids_to_items.each do |item, qty|
      oi = OrderItem.new(item: item, order: order, quantity: qty, price: item.price, fulfilled: false )
      oi.save
    end
    order.save
  end

end
