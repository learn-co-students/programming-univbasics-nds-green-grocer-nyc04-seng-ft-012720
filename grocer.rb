def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  i = 0
  while i < collection.length do 
    if name == collection[i][:item]
      return collection[i]
    end
    i += 1 
  end 
  return nil
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  consolidated_cart = []
  i = 0 
  while i < cart.length do
    cart_item = cart[i][:item]
    item = find_item_by_name_in_collection(cart_item,consolidated_cart)
    if item
      item[:count] += 1
    else
      cart[i][:count] = 1
      consolidated_cart << cart[i]
    end  
    i += 1
  end
  return consolidated_cart
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  i = 0 
  while i < coupons.length do
    cart_item = find_item_by_name_in_collection((coupons[i][:item]), cart)
    couponed_item = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item, cart)
    if cart_item && (cart_item[:count] >= coupons[i][:num])
      if cart_item_with_coupon
        cart_item_with_coupon += coupons[i][:num]
        cart_item -= coupons[i][:num]
      else
        cart_item_with_coupon = {
        :item => couponed_item,
        :price => coupons[i][:cost] / coupons[i][:num],
        :clearance => cart_item[:clearance],
        :count => coupons[i][:num]}
        
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end  
    end
    i += 1
  end
  return cart
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  i = 0 
  while i < cart.length do
    if cart[i][:clearance] == true 
      cart[i][:price] -= (cart[i][:price] * 0.20)
    end
    i += 1
  end
  return cart
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  consolidated_discounts_applied = apply_clearance(couponed_cart)
  
  total = 0
  i = 0
  while i < consolidated_discounts_applied.length do 
    total += consolidated_discounts_applied[i][:count] * consolidated_discounts_applied[i][:price]
    if total > 100
      total -= (total * 0.10)
    end   
    i += 1
  end 
  return total
end
