class ChangeEstadoIdToBasePerson < ActiveRecord::Migration[5.2]
  def change
    rename_column :base_people, :estado_id, :estado
    change_column  :base_people, :estado, :string, limit: 3
  end
end
