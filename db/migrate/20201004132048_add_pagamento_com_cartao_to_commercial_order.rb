class AddPagamentoComCartaoToCommercialOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_orders, :pagamento_com_cartao, :boolean
  end
end
