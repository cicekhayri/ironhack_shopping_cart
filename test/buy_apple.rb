require_relative "../shopping_cart"

my_cart = ShoppingCart.new
my_cart.add(:oranges, 20)
my_cart.add(:oranges,5)
my_cart.add(:bananas, 4)
my_cart.print_the_cart
puts my_cart.calculate
