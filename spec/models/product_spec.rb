require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    # validation tests/examples here
    it 'should be able to save when given required fields' do
      @category = Category.new
      @product = Product.new(category: @category, name: 'Men\'s Classy shirt', price: 1, quantity: 1)
      @product.save!
      expect(@product.category).to be_present
      expect(@product.name).to be_present
      expect(@product.price).to be_present
      expect(@product.quantity).to be_present
    end
    it "should throw an error if name is blank" do
      @category = Category.new
      @product = Product.new(category: @category, name: nil, price: 1, quantity: 1)
      @product.validate
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

    it "should throw an error if category is blank" do
      @product = Product.new(category: nil, name: 'Men\'s Classy shirt', price: 1, quantity: 1)
      @product.validate
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end
    it "should throw an error if price is blank" do
      @category = Category.new
      @product = Product.new(category: @category, name: 'Men\'s Classy shirt', price: nil, quantity: 1)
      @product.validate
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end
    it "should throw an error if quantity is blank" do
      @category = Category.new
      @product = Product.new(category: @category, name: 'Men\'s Classy shirt', price: 1, quantity: nil)
      @product.validate
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end
  end
end