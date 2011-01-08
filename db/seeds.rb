Currency.create({
    :id=>1,
    :name=>"Dollars",
    :format=>"%u%n",
    :sign=> "$",
    :separator=> ".",
    :delimiter=> ",",
    :paypal_currency_code=> "USD",
    :minimum=>1
})

Currency.create({
    :id=>2,
    :name=>"Euro",
    :format=>"%u%n",
    :sign=> "&euro;",
    :separator=> ".",
    :delimiter=> ",",
    :paypal_currency_code=> "EUR",
    :minimum=>1
})

Currency.create({
    :id=>3,
    :name=>"Baht",
    :format=>"%n %u",
    :sign=> "baht",
    :separator=> ".",
    :delimiter=> ",",
    :paypal_currency_code=> "THB",
    :minimum=>5
})    

Currency.create({
    :id=>4,
    :name=>"Pounds",
    :format=>"%u%n",
    :sign=> "&pound",
    :separator=> ",",
    :delimiter=> ".",
    :paypal_currency_code=> "GBP",
    :minimum=>1
})  