class Commercial::Order < ActiveRecord::Base

  belongs_to :person, class_name: "Base::Person", foreign_key: "people_id"

  has_many :order_itens, class_name: "Commercial::OrderItem"
end
