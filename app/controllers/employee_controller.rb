class EmployeeController < ApplicationController
  skip_before_action(:force_employee_sign_in, { only: [:index] })

  def index
    path_user = params.fetch('path_id')
    matching_employee = Employee.where({ id: path_user })
    @employee = matching_employee.first

    render template: 'users/index.html.erb'
  end
end
