require 'pry'
require 'date'


class ShoppingCartCalculator

  def initialize(season)
    @season = season
    get_prices
    get_discounts
    prices_of_day
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

  def special_gift_for_grapes
    if @cart.has_key?(:grapes) && @cart[:grapes] >= 4
      self.add(:bananas, 1)
    end
  end

  def calculate
    
    sum = 0
    @cart.each do |item, quantity|
      sum += quantity * @prices[item] * @discount[item]
    end

    special_gift_for_grapes

    return sum
  end

end

class ShoppingCart < ShoppingCartCalculator
  def initialize(season)
    @cart = {}
    super
  end

  def add(item, quantity)
    if @cart.has_key?(item)
      @cart[item] += quantity      
    else
      @cart[item] = quantity
    end
  end

  def print_the_cart
    puts @cart
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
#my_calc = Calculator.new("summer",my_cart)
puts my_cart.calculate
puts Time.now
my_cart.print_the_cart