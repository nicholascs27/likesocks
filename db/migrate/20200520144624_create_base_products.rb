class CreateBaseProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :base_products do |t|

      t.string :descricao, limit: 120
      t.integer :product_model_id
      t.decimal :preco, precision: 8, scale: 2
      t.integer :quantidade_estoque
      t.integer :quantidade_estoque_minimo
      t.timestamps
    end
  end
end
