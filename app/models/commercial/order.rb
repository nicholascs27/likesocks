class Commercial::Order < ActiveRecord::Base

  include AASM

  attr_accessor :order_items_hidden

  belongs_to :person, class_name: "Base::Person", foreign_key: "people_id"

  has_many :order_items, class_name: "Commercial::OrderItem"

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  validates_associated :order_items

  before_create :gerar_codigo
  after_save :gravar_valor_total_do_pedido

  enum status: {
    aberto: 1,
    fechado: 2,
    cancelado: 3
  }

  aasm column: :status, enum: true, whiny_transitions: false do
    state :aberto, :initial => true
    state :cancelado
    state :fechado
    
    event :finalizar do
      transitions from: :aberto, to: :fechado do
        guard do
          order_items.any? && person.present? && data_do_pedido.present? && !self.cancelado?
        end
        after do
					diminui_estoque_do_produto
				end
      end
    end

    event :cancelar do
      transitions to: :cancelado do
        guard do
          !self.cancelado?
        end

        after do
          retorna_estoque_do_produto
        end
      end
    end

    event :voltar_para_aberto do
      transitions from: :cancelado, to: :aberto do
        guard do
          self.cancelado?
        end
      end
      transitions from: :fechado, to: :aberto do
        guard do
          self.fechado?
        end

        after do
          retorna_estoque_do_produto
        end
      end
    end
  end

  # Ações
	def gerar_codigo
		self.codigo = "LS#{Commercial::Order.maximum(:id).to_i + 1}"
  end
  
  def gravar_valor_total_do_pedido
    total = self.order_items.sum(&:valor_total_do_item)
    if self.desconto.present?
      total = total - (total * (self.desconto.to_f / 100).to_f)
    end
    self.update_column(:valor_total, total)
  end

  def diminui_estoque_do_produto
    order_items.each do |order_item|
      order_item.product.quantidade_estoque -= order_item.quantidade
      order_item.product.save(validate: false)
    end
  end

  def retorna_estoque_do_produto
    order_items.each do |order_item|
      order_item.product.quantidade_estoque += order_item.quantidade
      order_item.product.save(validate: false)
    end
  end

end
