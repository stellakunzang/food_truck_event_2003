class FoodTruck
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new { |hash, key| hash[key] = 0 }
  end

  def check_stock(item)
    inventory[item]
  end

  def stock(item, quantity)
    inventory[item] += quantity
  end

  def potential_revenue
    revenue = 0
    inventory.each do |item, count|
      revenue += (item.price * count)
    end
    revenue 
  end

end
