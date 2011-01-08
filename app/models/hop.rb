class Hop < ActiveRecord::Base
  

  validates_presence_of :facebook_id, :message => "facebook_id must not be empty."
  validates_presence_of :bus_id, :message => "bus_id must not be empty."
  validates_presence_of :created_date, :message => "created_date must not be empty."
 

end