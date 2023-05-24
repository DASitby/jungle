require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates the presence of name' do
      product = Product.new(name: nil)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end
     it 'validates the presence of price' do
      product = Product.new(price_cents: nil)
      expect(product).not_to be_valid
      expect(product.errors[:price_cents]).to include("is not a number")
    end
    it 'validates the presence of quantity' do
      product = Product.new(quantity: nil)
      expect(product).not_to be_valid
      expect(product.errors[:quantity]).to include("can't be blank")
    end
    it 'validates the presence of category' do
      product = Product.new(category: nil)
      expect(product).not_to be_valid
      expect(product.errors[:category]).to include("can't be blank")
    end
  end
end
