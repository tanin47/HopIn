class Bus < ActiveRecord::Base

  STATUS_ACTIVE = "ACTIVE"
  STATUS_FINISHED = "FINISHED"
  
  validates_presence_of :name, :message => "Name must not be empty."
  validates_presence_of :why, :message => "Why must not be empty."
  validates_presence_of :amount, :message => "Amount must not be empty."
  validates_presence_of :capacity, :message => "Capacity must not be empty."
  validates_presence_of :facebook_id, :message => "facebook_id must not be empty."
  validates_presence_of :created_date, :message => "created_date must not be empty."
  validates_presence_of :currency_code, :message => "Currency code must not be empty."


end