class Employee < ActiveRecord::Base
  has_many :clock_in_events
  has_secure_password
end
