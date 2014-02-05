Given(/^customers named$/) do |customers|
  @customers = customers.raw.flatten#.map {|name| Customer.new(name) }
end

Given(/^products called$/) do |products|
  @products = products.raw.flatten
end

When(/^I run the suitability score calculator$/) do
  @calculator = Calculator.new(@customers, @products)
end

Then(/^I should see the following suitability scores:$/) do |scores|
  @calculator.output.should == scores.raw.flatten.count
end
