get '/' do
  erb :index
end

post '/login' do
	employee = Employee.find_by_email(params[:email])
    if employee && employee.authenticate(params[:password])
      session[:employee_id] = employee.id
      redirect "/employee/#{employee.id}"
    else
      redirect '/login'
    end
end

get '/logout' do
  @user = Employee.find(session[:employee_id])
  session[:employee_id] = nil
  redirect '/'
end

get '/admin/login' do
	erb :admin_login
end

post '/admin/login' do
	admin = Admin.find_by_email(params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect "/admin"
    else
      redirect '/admin/login'
    end
end

post '/admin/logout' do
	session.clear
	redirect '/admin/login'
end

get '/admin' do
	if session[:admin_id]
		@jobs = Job.all
		@employees = Employee.all
		erb :admin
	else
		redirect '/'
	end
end

get '/employee/new' do
	erb :new_employee
end

get "/employee/:id" do 
	@employee = Employee.find(params[:id])
	if @employee.id == session[:employee_id]
		@clock_in_events = @employee.clock_in_events.all
		@jobs = Job.all
		erb :employee_show
	else
		redirect '/'
	end
end

post '/employee/create' do
	employee = Employee.create(params)
	puts params
		if employee.save
			session[:employee_id] = employee.id
			redirect "/admin"
		else
			redirect '/admin'
		end
end

get '/job/new' do
	erb :job_new
end

get '/jobs' do
	@jobs = Job.all
	erb :jobs
end

get '/job/:id' do
	@job = Job.find(params[:id])
	@employees = @job.employees
	@job.total_hours
	# if @job.clock_in_events.count >= 2
	# 	puts @job.employee_job_hours(2)
	# end
	erb :job_show
end

post '/job/create' do
	job = Job.create(params)
	redirect '/admin'
end

post '/clock_in/create' do
	employee = Employee.find(params[:employee_id])
	clock_in_event = employee.clock_in_events.create(params)
	redirect "/employee/#{employee.id}"
end

post '/add_clock_in' do
	datetime = DateTime.parse("#{params[:date]} #{params[:time]} #{params[:am_pm]}")
	ClockInEvent.create(employee_id: params[:employee], job_id: params[:job], created_at: datetime)
	redirect "/job/#{params[:job]}"
end

post '/clockin/edit/:id' do
	ci = ClockInEvent.find(params[:id])
	datetime = DateTime.parse("#{params[:date]} #{params[:time]}")
	ci.update_attributes(:created_at => datetime)
	redirect '/admin'
end

post '/clockin/delete/:id' do
	ci = ClockInEvent.find(params[:id])
	ci.delete
	redirect '/admin'
end
