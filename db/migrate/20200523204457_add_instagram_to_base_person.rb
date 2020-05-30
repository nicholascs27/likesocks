class AddInstagramToBasePerson < ActiveRecord::Migration[5.2]
  def change
    add_column :base_people, :instagram, :string, limit: 60
  end
end
