require "minitest/autorun"
require "minitest/pride"
require "pry"
require './lib/item'
require './lib/food_truck'

class FoodTruckTest < Minitest::Test

  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  def test_it_exists
    assert_instance_of FoodTruck, @food_truck
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Pies", @food_truck.name
    assert_equal ({}), @food_truck.inventory
  end

  def test_it_can_stock_and_check_stock
    assert_equal 0, @food_truck.check_stock(@item1)
    @food_truck.stock(@item1, 30)
    assert_equal 30, @food_truck.check_stock(@item1)
    assert_equal 0, @food_truck.check_stock(@item2)
  end

  def test_it_can_add_to_stock
    @food_truck.stock(@item1, 30)
    assert_equal 30, @food_truck.check_stock(@item1)
    @food_truck.stock(@item1, 25)
    assert_equal 55, @food_truck.check_stock(@item1)
  end

  def test_inventory_output
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)
    @food_truck.stock(@item2, 12)
    expected = ({@item1 => 55, @item2 => 12})
    assert_equal expected, @food_truck.inventory
  end

  def test_potential_revenue
    @food_truck.stock(@item1, 35)
    @food_truck.stock(@item2, 7)
    assert_equal 148.75, @food_truck.potential_revenue
  end

  def test_it_can_list_items
    @food_truck.stock(@item1, 35)
    @food_truck.stock(@item2, 7)
    assert_equal ['Peach Pie (Slice)','Apple Pie (Slice)'], @food_truck.list_items
  end
end
