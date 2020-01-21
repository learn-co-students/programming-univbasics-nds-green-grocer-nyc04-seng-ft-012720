def find_item_by_name_in_collection(name, collection)
  coll_index = 0
while coll_index < collection.length do
  if collection[coll_index][:item] == name
    return collection[coll_index]
end
coll_index += 1
end
nil
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
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.


def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
      cart_item_with_coupon[:count] += coupons[counter][:num]
      cart_item[:count] -= coupons[counter][:num]
    else
      cart_item_with_coupon = {
        :item => couponed_item_name,
        :price => coupons[counter][:cost] / coupons[counter][:num],
        :clearance => cart_item[:clearance],
        :count => coupons[counter][:num]
      }
      cart << cart_item_with_coupon
      cart_item[:count] -= coupons[counter][:num]
    end
  end
    counter += 1
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  counter = 0
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price]*0.8).round(2)
    end
      counter+=1
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(couponed_cart)
  counter = 0
  cart_total = 0
  while counter < clearance_cart.length do
    cart_total += clearance_cart[counter][:price] * clearance_cart[counter][:count]
    counter+=1
  end
  if cart_total > 100
    cart_total = cart_total * 0.9
  end
  cart_total
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
