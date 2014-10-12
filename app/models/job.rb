class Job < ActiveRecord::Base
  has_many :clock_in_events
  has_many :employees

  geocoded_by :address
  after_validation :geocode

  def address
  	street  = self.street_address
  	city    = self.city
  	zipcode = self.zipcode

  	[street, city, zipcode].compact.join(', ')
  end

  def employees
  	employees = []
  	self.clock_in_events.each do |ci|
  		employees << Employee.find(ci.employee_id)
  	end
  	employees.uniq
  end

  def employee_clock_ins(employee_id)
  	self.clock_in_events.where(employee_id: employee_id)
  end

  def employee_job_hours(employee_id)
  	clock_ins = self.employee_clock_ins(employee_id)
  	if clock_ins.count >= 2
	  	hours = []
	  	clock_ins.each_with_index do |ci, index|
	  		if (index % 2 != 0)
	  			hours << (clock_ins[index].created_at - clock_ins[index -1].created_at)/60/60
	  		end
	  	end
	  	sum = hours.inject(:+).round(2)
  	else
  		sum = 0
  	end
  	sum
  	# puts (sum/60/60)
  end

  def total_hours
  	# job = self
  	clock_ins = self.clock_in_events.group_by{|ci| ci.employee_id}
  	# p clock_ins
  	hours_array = []
    if clock_ins.count >= 2
    	clock_ins.each do |ci|
    		if ci.count % 2 == 0
    			emp_hours = self.employee_job_hours(ci[0])
    			hours_array << (emp_hours)
    		else
    			ci = ci[0..ci[-2]]
    			emp_hours = self.employee_job_hours(ci[0])
    			hours_array << (emp_hours)
    		end
    	end
    	sum = hours_array.inject(:+).round(2)
    else
      sum = 0
    end
    sum
  end
end
