class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    food_trucks << truck
  end

  def food_truck_names
    food_trucks.map {|truck| truck.name }
  end

  def food_trucks_that_sell(item)
    food_trucks.find_all do |truck|
      truck.inventory.include?(item)
    end
  end

  def sorted_item_list
    all_items = []
    food_trucks.each do |truck|
      truck.list_items.each do |item|
        all_items << item
      end
    end
    all_items.sort.uniq
  end

  def total_inventory
    total_inventory = Hash.new { |hash, key| hash[key] = {quantity: 0, food_trucks: []} }
    food_trucks.each do |truck|
      truck.inventory.each do |item, count|
        total_inventory[item][:quantity] += count
        total_inventory[item][:food_trucks] << truck
      end
    end
    total_inventory
  end

  def overstocked_items
    overstock = []
    total_inventory.find_all do |item, info|
      if info[:quantity] > 50 && info[:food_trucks].length > 1
        overstock << item
      end
    end
    overstock
  end

  def sell(item, quantity)
    index = 0
    if total_inventory[item][:quantity] < quantity
      false
    elsif total_inventory[item][:quantity] >= quantity && total_inventory[item][:food_trucks][0].check_stock(item) >= quantity
      total_inventory[item][:food_trucks][0].deplete(item, quantity)
      return true
    else
      # until quantity == 0
        if total_inventory[item][:food_trucks][index].check_stock(item) < quantity
          total = total_inventory[item][:food_trucks][index].check_stock(item)
          total_inventory[item][:food_trucks][index].deplete(item, total)
          quantity -= total
          index += 1
        elsif total_inventory[item][:food_trucks][0].check_stock(item) >= quantity
          total_inventory[item][:food_trucks][0].deplete(item, quantity)
          quantity = 0
        end
      return true
    end
  end

end
