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

  def list_items
    inventory.map {|item, count| item.name}
  end

  def deplete(item, quantity)
    if inventory[item] >= quantity
      inventory[item] -= quantity
    else
      inventory[item] = 0
    end 
  end
end
