require "minitest/autorun"
require "minitest/pride"
require "pry"
require './lib/item'
require './lib/food_truck'
require './lib/event'

class EventTest < Minitest::Test

  def setup
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 2)
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @food_truck3.stock(@item1, 65)
  end

  def test_it_exists
    assert_instance_of Event, @event
  end

end
