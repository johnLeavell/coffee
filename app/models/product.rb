# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string
#  price       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
class Product < ApplicationRecord
  belongs_to :category, :required => true, :class_name => "Category", :foreign_key => "category_id", :counter_cache => true
end
