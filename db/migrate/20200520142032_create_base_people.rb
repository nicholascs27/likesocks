class CreateBasePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :base_people do |t|
      t.string :nome, limit: 80
      t.string :cpf, limit: 11
      t.string :cnpj, limit: 14
      t.string :cep, limit: 8
      t.string :logradouro, limit: 120
      t.string :numero, limit: 8
      t.string :complemento, limit: 80
      t.string :bairro, limit: 60
      t.integer :estado_id
      t.string :cidade, limit: 80
      t.string :telefone, limit: 15
      t.string :email, limit: 120
      t.date :data_de_nascimento
      t.date :data_do_cadastro
      t.text :observacoes

      t.timestamps
    end
  end
end
