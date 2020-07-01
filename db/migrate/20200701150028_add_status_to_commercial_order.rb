class AddStatusToCommercialOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :commercial_orders, :status, :integer
  end
end
