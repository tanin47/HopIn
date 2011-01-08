class Hop < ActiveRecord::Base
  

  validates_presence_of :facebook_id, :message => "facebook_id must not be empty."
  validates_presence_of :bus_id, :message => "bus_id must not be empty."
  validates_presence_of :created_date, :message => "created_date must not be empty."
<<<<<<< HEAD
 
=======
>>>>>>> 20227bde3fadee0856e453a03ee7ad0b99ac3f49

end