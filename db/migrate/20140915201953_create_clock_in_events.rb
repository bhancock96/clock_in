class CreateClockInEvents < ActiveRecord::Migration
  def change
  	create_table :clock_in_events do |t|
  		t.string :job_address
  		t.string :event
  		t.string :latitude
  		t.string :longitude
  		t.belongs_to :employee
      t.belongs_to :job

  		t.timestamps
  	end
  end
end
