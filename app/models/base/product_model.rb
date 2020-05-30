class Base::ProductModel < ApplicationRecord

  has_many :products, class_name: "Base::Product", dependent: :restrict_with_exception

  validates :descricao, presence: :true
end
