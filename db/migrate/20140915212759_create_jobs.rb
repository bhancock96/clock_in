class CreateJobs < ActiveRecord::Migration
  def change
  	create_table :jobs do |t|
  		t.string :name
  		t.string :street_address
  		t.string :city
  		t.string :zipcode

  		t.timestamps
  	end
  end
end
