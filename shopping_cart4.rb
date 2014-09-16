require 'pry'
require 'date'

class ShoppingCart
  def initialize(season)
    @season = season
    @cart = {}
  end

  def add(item, quantity)
    if @cart.has_key?(item)
      @cart[item] += quantity      
    else
      @cart[item] = quantity
    end
  end

  def special_gift_for_grapes
    if @cart.has_key?(:grapes) && @cart[:grapes] >= 4
      self.add(:bananas, 1)
    end
  end

  def calculate_shopping_cart_cost
    sum = 0
    new_shop_line_calculator = ShoppingLineCalculator.new
    @cart.each do |item, quantity|
      new_line_cost = new_shop_line_calculator.calculate(item, quantity, @season)
      sum +=  new_line_cost
    end
    return sum
  end

  def apply_special_gift
    special_gift_for_grapes
  end
  
  def calculate_cost
    @cost = calculate_shopping_cart_cost
    apply_special_gift
    return @cost
  end
  
  def print_the_cart
    puts @cart
  end
end


class ShoppingLineCalculator

  attr_reader :line_cost

  def calculate(item, quantity, season)
    new_item_price = ItemPrice.new(season) 
    @line_cost = new_item_price.item_price(item) * new_item_price.item_discount(item) * quantity
  end    
end

class ItemPrice
  def initialize(season)
    @season = season
    get_prices
    get_discounts
    prices_of_day
  end

  def item_price(item)
    @prices[item]
  end
  
  def item_discount(item)
    @discount[item]
  end

  def get_discounts
    @discount = {:bananas => 1, :apples => 0.5, :oranges => 2.0/3, :grapes => 1, :watermelon => 1}
  end

  def prices_of_day
    @prices[:watermelon] *= 2 if Date.parse('2014-09-21').sunday? 
  end

  def get_prices
    @prices = case @season
    when "winter"
      {:bananas => 21, :apples => 12, :oranges => 5, :grapes => 15, :watermelon => 50}
    when "spring"
      {:bananas => 20, :apples => 10, :oranges => 5, :grapes => 15, :watermelon => 50}
    when "summer"
      {:bananas => 20, :apples => 10, :oranges => 2, :grapes => 15, :watermelon => 50}
    when "autumn"
      {:bananas => 20, :apples => 15, :oranges => 5, :grapes => 15, :watermelon => 50}
    else
      {:bananas => 20, :apples => 15, :oranges => 5, :grapes => 15, :watermelon => 50}
    end
  end

end  
my_cart = ShoppingCart.new("summer")

#my_cart.season = "winter"
#puts my_cart.season
my_cart.add(:oranges, 3)
my_cart.add(:grapes,4)
my_cart.add(:apples, 2)
my_cart.add(:bananas, 4)
my_cart.add(:watermelon, 2)
puts my_cart.calculate_cost
puts Time.now
my_cart.print_the_cart