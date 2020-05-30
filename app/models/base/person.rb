class Base::Person < ActiveRecord::Base

  validates :nome, :logradouro, :numero, :bairro, :cidade, presence: true

  validates_length_of :nome, maximum: 80
	validates_length_of :cpf, maximum: 11
	validates_length_of :cnpj, maximum: 14
	validates_length_of :cep, is: 8, allow_blank: true
	validates_length_of :logradouro, maximum: 120
	validates_length_of :numero, maximum: 8
	validates_length_of :complemento, maximum: 80
	validates_length_of :bairro, maximum: 60
	validates_length_of :telefone, maximum: 15
	validates_length_of :email, maximum: 120
	validates_length_of :instagram, maximum: 60

  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, allow_blank: true

  TIPO_DA_FOLHA = {"title"=>"AN - Ativo Normal", "id"=>"AN"}, {"title"=>"AC - Ativo Complementar", "id"=>"AC"}, {"title"=>"AD - Ativo 13º Salário", "id"=>"AD"}, {"title"=>"IN - Inativo Normal", "id"=>"IN"}, {"title"=>"IC - Inativo Complementar", "id"=>"IC"}, {"title"=>"ID - Inativo 13º Salário", "id"=>"ID"}, {"title"=>"PN - Pensionista Normal", "id"=>"PN"}, {"title"=>"PC - Pensionista Complementar", "id"=>"PC"}, {"title"=>"PD - Pensionista 13º Salário", "id"=>"PD"}

  ESTADOS_BRASILEIROS =
    {
      "Acre": "AC",
      "Alagoas": "AL",
      "Amapá": "AP",
      "Amazonas": "AM",
      "Bahia": "BA",
      "Ceará": "CE",
      "Distrito Federal": "DF",
      "Espírito Santo": "ES",
      "Goiás": "GO",
      "Maranhão": "MA",
      "Mato Grosso": "MT",
      "Mato Grosso do Sul": "MS",
      "Minas Gerais": "MG",
      "Pará": "PA",
      "Paraíba": "PB",
      "Paraná": "PR",
      "Pernambuco": "PE",
      "Piauí": "PI",
      "Rio de Janeiro": "RJ",
      "Rio Grande do Norte": "RN",
      "Rio Grande do Sul": "RS",
      "Rondônia": "RO",
      "Roraima": "RR",
      "Santa Catarina": "SC",
      "São Paulo": "SP",
      "Sergipe": "SE",
      "Tocantins": "TO"
    }

  def endereco_completo
		if numero.present? && bairro.present? && cep.present?
			"#{logradouro}, #{numero}, #{bairro}, #{cidade}, CEP: #{cep}"
		elsif numero.present? && bairro.present?
			"#{logradouro}, #{numero}, #{bairro}, #{cidade}"
		else
			"#{logradouro}, #{cidade}"
		end
	end
end
