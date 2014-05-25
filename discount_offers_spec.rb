# require 'byebug'

# describe "Customer" do
#   let(:customer) { Customer.new("Matt Sroufe") }
#   let(:product) { Product.new("football") }

#   it "is valid" do
#     expect(customer).to be_an_instance_of Customer
#   end

#   describe "#suitability_score" do
#     it "returns the customer's suitability score for the given product" do
#       expect(customer.suitability_score(product)).to eq(9)
#     end
#   end
# end

# describe "Calculator" do
#   let(:calculator_1) { Calculator.new(['Jack Abraham','John Evans','Ted Dziuba'],['iPad 2 - 4-pack','Girl Scouts Thin Mints','Nerf Crossbow']) }
#   let(:calculator_2) { Calculator.new(['Jeffery Lebowski','Walter Sobchak','Theodore Donald Kerabatsos','Peter Gibbons','Michael Bolton','Samir Nagheenanajar'],['Half & Half','Colt M1911A1','16lb bowling ball','Red Swingline Stapler','Printer paper','Vibe Magazine Subscriptions - 40 pack']) }
#   let(:calculator_3) { Calculator.new(['Jareau Wade','Rob Eroh','Mahmoud Abdelkader','Wenyi Cai','Justin Van Winkle','Gabriel Sinkin','Aaron Adelson'],['Batman No. 1','Football - Official Size','Bass Amplifying Headphones','Elephant food - 1024 lbs','Three Wolf One Moon T-shirt','Dom Perignon 2000 Vintage']) }

#   describe "customer_product_permutations" do
#     it "returns the customer product permutations" do
#       expect(calculator_1.customer_product_permutations).to eq([[0, 1, 2], [0, 2, 1], [1, 0, 2], [1, 2, 0], [2, 0, 1], [2, 1, 0]])
#     end
#   end

#   describe ".best_offer" do
#     it "returns the best offer given the customers and products" do
#       expect(calculator_1.best_offer).to eq('21.00')
#       expect(calculator_2.best_offer).to eq('83.50')
#       expect(calculator_3.best_offer).to eq('71.25')
#     end
#   end
# end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def suitability_score(product)
    if product.name.letter_count % 2 == 0
      ss = name.vowel_count * 1.5
    else
      ss = name.consonant_count
    end
    ss *= 1.5 if name.letter_count.gcd(product.name.letter_count) > 1
    ss
  end
end

Product = Struct.new(:name)

class Calculator
  attr_reader :customers, :products

  def initialize(customers, products)
    @customers = customers.map { |customer| Customer.new(customer) }
    @products = products.map { |product| Product.new(product) }
  end

  def customer_product_permutations
    customers.each_index.to_a.permutation(products.count).to_a
  end

  def best_offer
    bo = customer_product_permutations.map do |permutation|
      permutation.each_with_index.map do |i, index|
        customers[i].suitability_score(products[index])
      end.inject(:+)
    end.max
    sprintf("%.2f", bo) if bo
  end
end

class String
  def letter_count
    downcase.count(('a'..'z').to_a.join(''))
  end

  def vowel_count
    downcase.count('aeiouy')
  end

  def consonant_count
    downcase.count('bcdfghjklmnpqrstvwxz')
  end
end

File.open(ARGV[0]).each_line do |line|
  input = line.split(";")
  customers = input[0].split(',')
  products = input[1].split(',')
  puts Calculator.new(customers, products).best_offer
end
