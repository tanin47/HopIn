class PaypalIpn < ActiveRecord::Base
  
  STATUS_PENDING = "Pending"
  STATUS_VERIFIED = "Verified"
  STATUS_INVALID = "Invalid"
  STATUS_BUY_OFFER_INVALID = "BuyOfferInvalid"
  
end