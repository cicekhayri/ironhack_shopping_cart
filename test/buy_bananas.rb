require_relative "../shopping_cart"

new_cart_banana = ShoppingCart.new

new_cart_banana.add :bananas, 2
new_cart_banana.add :bananas, 3
new_cart_banana.add :bananas, 5
new_cart_banana.print_the_cart