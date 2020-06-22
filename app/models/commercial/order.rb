class Commercial::Order < ActiveRecord::Base

  attr_accessor :order_items_hidden

  belongs_to :person, class_name: "Base::Person", foreign_key: "people_id"

  has_many :order_items, class_name: "Commercial::OrderItem"

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  validates_associated :order_items

  before_create :gerar_codigo
  after_save :gravar_valor_total_do_pedido

  # Ações
	def gerar_codigo
		self.codigo = "LS#{Commercial::Order.maximum(:id).to_i + 1}"
  end
  
  def gravar_valor_total_do_pedido
    total = self.order_items.sum(&:valor_total_do_item)
    self.update_column(:valor_total, total)
  end

end
