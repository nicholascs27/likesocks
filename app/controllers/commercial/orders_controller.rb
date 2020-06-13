class Commercial::OrdersController < SiteController

  before_action :set_order, except: [:index, :new, :create]
  before_action :disponibiliza_dependencias, only: [:new, :edit]

  def index
    @q = Commercial::Order.ransack(params[:q])
    @orders = @q.result(distinct: false)
  end

  def show
  end

  def new
    @order = Commercial::Order.new
  end

  def create
    @order = Commercial::Order.new(order_params)

    if @order.save
      redirect_to commercial_orders_path, success: 'Pedido cadastrada com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update
      redirect_to commercial_orders_path, success: 'Pedido atualizado com sucesso.'
    else
      render :new
    end
  end

  def destroy
    if @order.destroy
      redirect_to commercial_orders_path, success: "Registro apagado com sucesso"
    else
      redirect_to commercial_orders_path, alert: "Não foi possível excluir"
    end
  end

  private

  def disponibiliza_dependencias
    @clientes = Base::Person.all.order(:nome)
  end

  def set_person
    @person = Base::Person.find( params[:id] )
  end

  def order_params
    params.require(:commercial_order).permit(
      :data_do_pedido, :people_id, :valor_total
    )
  end
end
