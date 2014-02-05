class Calculator
  attr_reader :customers, :products

  def initialize(customers, products)
    @customers = []
    @products = []

    customers.each do |name|
      @customers << Customer.new(name)
    end

    products.each do |name|
      @products << Product.new(name)
    end
  end

  def even_letter_products
    even_letter_products = []
    products.each do |product|
      even_letter_products << product if product.length % 2 == 0
    end
    even_letter_products
  end

  def output
    Customer.customers.count
  end
end

class Customer
  attr_reader :name
  @@customers = []

  def initialize(name)
    @name = name
    @@customers << self
  end
  
  def self.customers(n = nil)
    n ? @@customers[n] : @@customers
  end

  def self.find_by_name(name)
    customers.each do |customer|
      return customer if customer.name == name
    end
  end

  def longer_name(other)
    self.name.length > other.name.length ? self.name : other.name
  end

  def greater_than?(other)
    self.name.length > other.name.length
  end
end

class Product
  attr_reader :name
  @@products = []

  def initialize(name)
    @name = name
    @@products << self
  end
  
  def self.products(n = nil)
    n ? @@products[n] : @@products
  end

  def self.find_by_name(name)
    products.each do |product|
      return product if product.name == name
    end
  end

  def longer_name(other)
    self.name.length > other.name.length ? self.name : other.name
  end

  def greater_than?(other)
    self.name.length > other.name.length
  end
end

# Item = Struct.new(:price)
# Payment = Struct.new(:amount)

# CURRENCY = [ [10000, 'ONE HUNDRED'],
#              [5000,        'FIFTY'],
#              [2000,       'TWENTY'],
#              [1000,          'TEN'],
#              [500,          'FIVE'],
#              [200,           'TWO'],
#              [100,           'ONE'],
#              [50,    'HALF DOLLAR'],
#              [25,        'QUARTER'],
#              [10,           'DIME'],
#              [5,          'NICKEL'],
#              [1,           'PENNY'] ]

# class CashRegister
#   attr_reader :item, :payment, :change, :words

#   def initialize(item_price, payment_amount)
#     @item = Item.new(dollars_to_cents(item_price))
#     @payment = Payment.new(dollars_to_cents(payment_amount))
#     @change = (payment.amount - item.price)
#     @words = []
#   end

#   def dollars_to_cents(amount)
#     if amount.match('\.\d\d')
#       amount.gsub('.','').to_i
#     elsif amount.match('\.\d')
#       amount.insert(amount.size, '0').gsub('.','').to_i
#     else
#       amount.insert(amount.size, '00').to_i
#     end
#   end

#   def output
#     if change < 0
#       "ERROR"
#     elsif change == 0
#       "ZERO"
#     else
#       change_to_currency
#       words.join(",")
#     end
#   end

#   def change_to_currency
#     CURRENCY.each do |a|
#       num_to_cash(a.first, a.last)
#     end
#   end

#   def num_to_cash(number, cash)
#     if @change >= number
#       q = (@change/number)
#       i = 0
#       while i < q  do
#         words << cash
#         @change -= number
#         i += 1
#       end
#     end
#   end
# end
