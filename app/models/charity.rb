class Charity < ActiveRecord::Base

  validates_presence_of :name, :message => "Name must not be empty."
 
end