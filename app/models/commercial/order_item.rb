class Commercial::OrderItem < ActiveRecord::Base

  belongs_to :order, class_name: "Commercial::Order"
  belongs_to :product, class_name: "Base::Product"

  def valor_total_do_item
    quantidade.to_f * product.preco.to_f
	end
end
