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
    total_inventory.each do |item, info|
      if info[:quantity] > 50 && info[:food_trucks].length > 1
        overstock << item
      end
    end
    overstock
  end
end
