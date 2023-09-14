class EmployeeAuthenticationController < ApplicationController
  # Uncomment line 3 in this file and line 5 in ApplicationController if you want to force employees to sign in before any other actions.
  # skip_before_action(:force_employee_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "employee_authentication/sign_in.html.erb" })
  end

  def create_cookie
    employee = Employee.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if employee != nil
      are_they_legit = employee.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/employee_sign_in", { :alert => "Incorrect password." })
      else
        session[:employee_id] = employee.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/employee_sign_in", { :alert => "No employee with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "employee_authentication/sign_up.html.erb" })
  end

  def create
    @employee = Employee.new
    @employee.email = params.fetch("query_email")
    @employee.password = params.fetch("query_password")
    @employee.password_confirmation = params.fetch("query_password_confirmation")
    @employee.sign_in_count = params.fetch("query_sign_in_count")
    @employee.current_sign_in_at = params.fetch("query_current_sign_in_at")
    @employee.last_sign_in_at = params.fetch("query_last_sign_in_at")
    @employee.admin = params.fetch("query_admin", false)

    save_status = @employee.save

    if save_status == true
      session[:employee_id] = @employee.id
   
      redirect_to("/", { :notice => "Employee account created successfully."})
    else
      redirect_to("/employee_sign_up", { :alert => @employee.errors.full_messages.to_sentence })
    end
  end
    
  def edit_profile_form
    render({ :template => "employee_authentication/edit_profile.html.erb" })
  end

  def update
    @employee = @current_employee
    @employee.email = params.fetch("query_email")
    @employee.password = params.fetch("query_password")
    @employee.password_confirmation = params.fetch("query_password_confirmation")
    @employee.sign_in_count = params.fetch("query_sign_in_count")
    @employee.current_sign_in_at = params.fetch("query_current_sign_in_at")
    @employee.last_sign_in_at = params.fetch("query_last_sign_in_at")
    @employee.admin = params.fetch("query_admin", false)
    
    if @employee.valid?
      @employee.save

      redirect_to("/", { :notice => "Employee account updated successfully."})
    else
      render({ :template => "employee_authentication/edit_profile_with_errors.html.erb" , :alert => @employee.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @current_employee.destroy
    reset_session
    
    redirect_to("/", { :notice => "Employee account cancelled" })
  end
 
end
