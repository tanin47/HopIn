# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def successfully_pay_bus(bus)
    bus.status = Bus::STATUS_ACTIVE
    bus.save
  end
  
  def format_currency_by_code(currency_code,number)
   currency = Currency.first(:conditions=>{:paypal_currency_code=>currency_code})
   return number_to_currency(number, :unit => currency.sign, :separator => currency.separator, :delimiter => currency.delimiter, :format => currency.format)
  end
  
end
