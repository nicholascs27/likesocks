class Commercial::OrderItem < ActiveRecord::Base

  belongs_to :order, class_name: "Commercial::Order"
end
