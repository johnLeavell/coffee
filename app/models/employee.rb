# == Schema Information
#
# Table name: employees
#
#  id                 :integer          not null, primary key
#  admin              :boolean
#  avatar             :string
#  current_sign_in_at :datetime
#  email              :string
#  first_name         :string
#  last_name          :string
#  last_sign_in_at    :datetime
#  password_digest    :string
#  sign_in_count      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Employee < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
end
