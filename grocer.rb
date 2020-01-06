require 'pry'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  counter = 0 
  cart = nil 
  while counter < collection.length do 
        if name == collection[counter][:item]  
          cart = collection[counter] 
        end
    
  counter += 1 
  end 
  return cart
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  # puts cart
  new_cart = []
  counter = 0 
  while counter < cart.length do  
     cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
     if cart_item != nil 
       cart_item[:count] += 1  
     else 
       cart_item = {
          :item => cart[counter][:item],
          :price => cart[counter][:price],
          :clearance => cart[counter][:clearance],
          :count => 1
       }
       new_cart << cart_item
     end
  counter += 1
  end
  # binding.pry
  return new_cart 
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  # binding.pry
  while i < coupons.length do 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    coupon_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon 
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:counter] -= coupons[i][:num]
      else
        cart_item_with_coupon = { 
          :item=>coupon_item_name,
          :price=>coupons[i][:cost] / coupons[i][:num],
          :count=>coupons[i][:num],
          :clearance=>cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
    end
    i += 1  
  end
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.20)).round(2)
    end
  i += 1  
  end
  return cart
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
  con_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(con_cart, coupons)
  final_cart = apply_clearance(coup_cart)
  total = 0 
  i = 0 
  while i < final_cart.length do 
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end
  if total > 100 
    total = total - (total * 0.10).round(2) 
  end
  return total
end
