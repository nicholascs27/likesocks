# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_01_150028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_people", force: :cascade do |t|
    t.string "nome", limit: 80
    t.string "cpf", limit: 11
    t.string "cnpj", limit: 14
    t.string "cep", limit: 8
    t.string "logradouro", limit: 120
    t.string "numero", limit: 8
    t.string "complemento", limit: 80
    t.string "bairro", limit: 60
    t.string "estado", limit: 3
    t.string "cidade", limit: 80
    t.string "telefone", limit: 15
    t.string "email", limit: 120
    t.date "data_de_nascimento"
    t.date "data_do_cadastro"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "instagram", limit: 60
  end

  create_table "base_product_models", force: :cascade do |t|
    t.string "descricao", limit: 120
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "base_products", force: :cascade do |t|
    t.string "descricao", limit: 120
    t.integer "product_model_id"
    t.decimal "preco", precision: 8, scale: 2
    t.integer "quantidade_estoque"
    t.integer "quantidade_estoque_minimo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.integer "imagem_file_size"
    t.datetime "imagem_updated_at"
  end

  create_table "commercial_order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "quantidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
  end

  create_table "commercial_orders", force: :cascade do |t|
    t.string "codigo", limit: 10
    t.integer "people_id"
    t.string "cupom_desconto", limit: 12
    t.integer "desconto"
    t.decimal "valor_total", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "data_do_pedido"
    t.integer "status"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

end
