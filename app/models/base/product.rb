class Base::Product < ApplicationRecord

  belongs_to :product_model, class_name: "Base::ProductModel"

  has_attached_file :imagem, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\z/
  validates_attachment_size :imagem, in: 0..10.megabytes
	validates_attachment_file_name :imagem, matches: [/png\z/, /jpe?g\z/], message: 'Apenas PNG, JPG e JPEG'

  validates :descricao, :product_model_id, :preco, :quantidade_estoque, presence: :true

end
