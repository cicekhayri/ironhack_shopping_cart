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
    new_item_price = ItemPrice.new(item, season) 
    @line_cost = new_item_price.item_price * quantity
  end    
end

class ItemPrice
  def initialize(item, season)
    @season = season
    get_prices
    get_discounts
    prices_of_day
    @item_price = @prices[item] * @discount[item]
  end

  attr_reader :item_price

  def calculate
    @item_price = @prices[item]
  end
  
  def get_discounts
    @discount = {:bananas => 1, :apples => 0.5, :oranges => 2.0/3, :grapes => 1, :watermelon => 1}
  end

  def prices_of_day
    @prices[:watermelon] *= 2 if Date.parse('2014-09-20').sunday? 
  end

  def set_prices_for_season
    @price_spring = {:bananas => 20, :apples => 10, :oranges => 5, :grapes => 15, :watermelon => 50}
    @price_summer = {:bananas => 20, :apples => 10, :oranges => 2, :grapes => 15, :watermelon => 50}
    @price_autumn = {:bananas => 20, :apples => 15, :oranges => 5, :grapes => 15, :watermelon => 50}
    @price_winter = {:bananas => 21, :apples => 12, :oranges => 5, :grapes => 15, :watermelon => 50}
  end

  def get_prices
    set_prices_for_season

    @prices = case @season
    when "winter"
      @price_winter
    when "spring"
      @price_spring
    when "summer"
      @price_summer
    when "autumn"
      @price_autumn
    else
      @price_autumn
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