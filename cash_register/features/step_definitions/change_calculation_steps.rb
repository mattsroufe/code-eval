Given(/^an item with a purchase price of (.*)$/) do |price|
  @item_price = price
end

When(/^a customer pays with (.*)$/) do |payment|
  @payment_amount = payment
end

Then(/^the cash register should say (.*) is due to the customer$/) do |change|
  sale = CashRegister.new(@item_price, @payment_amount)
  sale.output.should == change
end