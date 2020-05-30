class Base::PersonsController < SiteController

  before_action :set_person, except: [:index, :new, :create]

  def index
    @q = Base::Person.ransack(params[:q])
    @persons = @q.result(distinct: false)
  end

  def show
  end

  def new
    @person = Base::Person.new
  end

  def create
    @person = Base::Person.new(person_params)

    if @person.save
      redirect_to base_persons_path, success: 'Pessoa cadastrada com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to base_persons_path, success: "Pessoa atualizada com sucesso"
    else
      render :edit, notice: "Não foi possível editar"
    end
  end

  def destroy
    if @person.destroy
      redirect_to base_persons_path, success: "Registro apagado com sucesso"
    else
      redirect_to base_persons_path, alert: "Não foi possível excluir"
    end
  end

  private

  def set_person
    @person = Base::Person.find( params[:id] )
  end

  def person_params
    params.require(:base_person).permit(
      :nome, :cpf, :cnpj, :logradouro, :numero, :bairro, :cep, :estado, :cidade,
      :complemento, :telefone, :data_de_nascimento, :email, :instagram
    )
  end

end
