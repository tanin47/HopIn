class Currency < ActiveRecord::Base
  
  USD = "USD"
  
  validates_presence_of :name
  validates_presence_of :format
  validates_presence_of :sign
  validates_presence_of :separator
  validates_presence_of :delimiter
  validates_presence_of :paypal_currency_code
  validates_presence_of :minimum
end