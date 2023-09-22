class AddAvatarToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :avatar, :string
  end
end
