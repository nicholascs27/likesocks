class CreateCommercialOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_orders do |t|

      t.string :codigo, limit: 10
      t.integer :people_id
      t.string :cupom_desconto, limit: 12
      t.integer :desconto
      t.decimal :valor_total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
