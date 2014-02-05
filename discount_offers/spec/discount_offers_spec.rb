require 'spec_helper'

describe Calculator do
  describe ".new" do
    before :all do
      Calculator.new(['John Cheese'], ['Computer'])
    end

    it "should return one new customer" do
      Customer.customers.count.should == 1
    end
    
    it "should return one new product" do
      Product.products.count.should == 1
    end
  end
end
