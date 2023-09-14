class ApplicationController < ActionController::Base
  before_action(:load_current_employee)
  
  # Uncomment line 5 in this file and line 3 in EmployeeAuthenticationController if you want to force employees to sign in before any other actions.
  # before_action(:force_employee_sign_in)
  
  def load_current_employee
    the_id = session[:employee_id]
    
    @current_employee = Employee.where({ :id => the_id }).first
  end
  
  def force_employee_sign_in
    if @current_employee == nil
      redirect_to("/employee_sign_in", { :notice => "You have to sign in first." })
    end
  end

end
