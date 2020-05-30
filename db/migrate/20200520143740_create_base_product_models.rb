class CreateBaseProductModels < ActiveRecord::Migration[5.2]
  def change
    create_table :base_product_models do |t|

      t.string :descricao, limit: 120
      t.timestamps
    end
  end
end
