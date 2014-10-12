class ClockInEvent < ActiveRecord::Base
  belongs_to :employee
  belongs_to :job

  def self.employee_clock_ins(employee_id)
  	ClockInEvent.where(employee_id: employee_id)
  end
end
