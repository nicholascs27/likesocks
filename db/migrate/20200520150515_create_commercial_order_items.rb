class CreateCommercialOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :commercial_order_items do |t|

      t.integer :order_id
      t.integer :quantidade

      t.timestamps
    end
  end
end
