CLEARANCE_ITEM_DISCOUNT_RATE = 0.20
BIG_PURCHASE_DISCOUNT_RATE = 0.10

def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    return collection[i] if name === collection[i][:item]
    i += 1
  end
  nil



  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  i = 0
 result = []

 while i < cart.count do
   item_name = cart[i][:item]
   which_item = find_item_by_name_in_collection(item_name, result)
   if which_item
     which_item[:count] += 1
   else
     cart[i][:count] = 1
     result << cart[i]
    end
   i += 1
  end
  result
end



def apply_coupon_amount(c)
  rounded_unit_price = (c[:cost].to_f * 1.0 / c[:num]).round(2)
  {
    :item => "#{c[:item]} W/COUPON",
    :price => rounded_unit_price,
    :count => c[:num]
  }
end



def apply_coupon_to_cart(matching_item, coupon, cart)
  matching_item[:count] -= coupon[:num]
  item_with_coupon = apply_coupon_amount(coupon)
  item_with_coupon[:clearance] = matching_item[:clearance]
  cart << item_with_coupon
end

  # made a first order method to make it easier for apply_coupon



def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
   while i < coupons.count do
     coupon = coupons[i]
     item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
     item_is_in_basket = !!item_with_coupon
     count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]

     if item_is_in_basket and count_is_big_enough_to_apply
       apply_coupon_to_cart(item_with_coupon, coupon, cart)
     end
     i += 1
   end

   cart
 end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
    while i < cart.length do
      item = cart[i]
      if item[:clearance]
        discounted_price = ((1 - CLEARANCE_ITEM_DISCOUNT_RATE) * item[:price]).round(2)
          item[:price] = discounted_price
      end
      i += 1
    end

  cart
end

def items_total_cost(i)
  i[:count] * i[:price]
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0
  i = 0

  ccart = consolidate_cart(cart)
  apply_coupons(ccart, coupons)
  apply_clearance(ccart)

  while i < ccart.length do
    total += items_total_cost(ccart[i])
    i += 1
  end

  total >= 100 ? total * (1.0 - BIG_PURCHASE_DISCOUNT_RATE) : total
end
