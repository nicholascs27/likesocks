class AddDateToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_orders, :data_do_pedido, :date
  end
end
