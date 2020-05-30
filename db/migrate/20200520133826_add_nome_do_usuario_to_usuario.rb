class AddNomeDoUsuarioToUsuario < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :user_name, :string
  end
end
