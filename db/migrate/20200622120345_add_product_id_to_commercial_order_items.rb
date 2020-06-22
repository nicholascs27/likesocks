class AddProductIdToCommercialOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_order_items, :product_id, :integer
  end
end
