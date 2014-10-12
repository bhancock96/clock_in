def current_user
  if session[:employee_id]
    @current_user ||= Employee.find(session[:employee_id])
  end
end

def current_admin
  if session[:admin_id]
  	@current_admin ||= Admin.find(session[:admin_id])
  end
end