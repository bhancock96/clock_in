class CreateEmployees < ActiveRecord::Migration
  def change
  	create_table :employees do |t|
  		t.string :first_name
  		t.string :last_name
  		t.string :email
  		t.string :password_digest
  		t.string :password_confirmation
  		t.string :status
  		t.string :position
  		t.string :clock_in_status, :default => "Out"
      t.belongs_to :job

  		t.timestamps
  	end
  end
end
