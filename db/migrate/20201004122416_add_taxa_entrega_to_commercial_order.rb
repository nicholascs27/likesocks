class AddTaxaEntregaToCommercialOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_orders, :taxa_entrega, :decimal, precision: 4, scale: 2
  end
end
