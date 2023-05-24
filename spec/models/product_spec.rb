require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.create(name: 'Example Category') }
    
    it 'validates the presence of name' do
      product = Product.new(name: nil, price_cents: 999, quantity: 1, category: category)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end
     it 'validates the presence of price' do
      product = Product.new(name: "David Sooley", price_cents: nil, quantity: 1, category: category)
      expect(product).not_to be_valid
      expect(product.errors[:price_cents]).to include("is not a number")
    end
    it 'validates the presence of quantity' do
      product = Product.new(name: "David Sooley", price_cents: 999, quantity: nil, category: category)
      expect(product).not_to be_valid
      expect(product.errors[:quantity]).to include("can't be blank")
    end
    it 'validates the presence of category' do
      product = Product.new(name: "David Sooley", price_cents: 999, quantity: 1, category: nil)
      expect(product).not_to be_valid
      expect(product.errors[:category]).to include("can't be blank")
    end
    it 'saves the product with all attributes filled in correctly' do
      product = Product.new(name: 'Example Product', price: 9.99, quantity: 10, category: category)
      expect(product).to be_valid
      expect { product.save }.to change { Product.count }.by(1)
    end
  end
end
