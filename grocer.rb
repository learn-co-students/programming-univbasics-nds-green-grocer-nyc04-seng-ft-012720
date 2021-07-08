def find_item_by_name_in_collection(name, collection)
   i = 0 
  while i < collection.length do 
    if collection[i][:item] == name
      return collection[i]
    end
  i += 1
  end
end

def consolidate_cart(cart)
   new_cart = []
  i = 0 
  while i < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[i][:item], new_cart)
    if new_cart_item != nil 
      new_cart_item[:count] += 1 
    else
      new_cart_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      }
      new_cart << new_cart_item
    end
    i += 1 
  end
  new_cart
end

def apply_coupons(cart, coupons)
  result = []
  if coupons.length == 0 
    return cart
  end
  count = 0 
  while count < cart.length do 

    citem = cart[count]

    couponitem = find_item_by_name_in_collection(citem[:item], coupons)

    if couponitem
      no_coupon_count = citem[:count] % couponitem[:num]
      # coupon_applied_count = citem[:count] - no_coupon_count
      per_unit_price = couponitem[:cost] / couponitem[:num]
      # couponitems_count = coupon_applied_count / couponitem[:num] 



      temp_hash = {
        :item => "#{citem[:item]} W/COUPON",
        :price => per_unit_price,
        :clearance => citem[:clearance],
        :count => couponitem[:num]
      }

      result << temp_hash


      citem[:count] = no_coupon_count
    end

    result << citem

    count += 1 
  end
  return result


end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] *= 0.8
    end

    i += 1 
  end
  return cart 
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied_cart = apply_coupons(consolidated_cart, coupons)
  clerance_applied_cart = apply_clearance(coupons_applied_cart)
  total = 0 
  i = 0 
  while i < clerance_applied_cart.length do 
    total += (clerance_applied_cart[i][:count] * clerance_applied_cart[i][:price])
    i += 1 
  end
  if total > 100 
    total *= 0.9 
  end
  return total.round(2)
end
