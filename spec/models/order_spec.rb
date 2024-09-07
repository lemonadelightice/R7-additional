require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:customer) { FactoryBot.create(:customer) }

  subject { Order.new(product_name: "Widget", product_count: 5, customer: customer) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a product_name" do
    subject.product_name = nil
    expect(subject).to_not be_valid
    expect(subject.errors[:product_name]).to include("can't be blank")
  end

  it "is invalid without a product_count" do
    subject.product_count = nil
    expect(subject).to_not be_valid
    expect(subject.errors[:product_count]).to include("can't be blank")
  end

  it "is invalid with a non-integer product_count" do
     subject.product_count = "abc"
    expect(subject).to_not be_valid
    expect(subject.errors[:product_count]).to include("is not a number")
  end

  it "is invalid with a negative product_count" do
    subject.product_count = -1
    expect(subject).to_not be_valid
    expect(subject.errors[:product_count]).to include("must be greater than or equal to 0")
  end

  it "is invalid without a customer" do
    subject.customer = nil
    expect(subject).to_not be_valid
    expect(subject.errors[:customer]).to include("must exist")
  end
end
