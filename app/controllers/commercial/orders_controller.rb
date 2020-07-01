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

  def show
  end
  

  def edit
  end

  def update
    if @order.update(order_params)
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

  def cancelar
    if @order.cancelar!
			redirect_to @order, notice: 'Pedido foi cancelado com sucesso.'
		else
			redirect_to @order, notice: 'Não foi possível cancelar o pedido'
		end
  end

  def finalizar
    if @order.finalizar!
      redirect_to @order, success: 'Pedido finalizado com sucesso.'
    else
      redirect_to @order, alert: 'Não foi possivel finalizar o pedido.'
    end
  end
  

  private

  def disponibiliza_dependencias
    @clientes = Base::Person.all.order(:nome)
    @products = Base::Product.all.order(:descricao)
    @products = Base::Product.all.where("quantidade_estoque > 0").order(:descricao)
    @products_select = Base::Product.all.order(:descricao).map do |produto|
      [
        produto.descricao,
        produto.id,
        {
          "data-valor-unitario" => produto.preco,
        }
      ]
    end
  end

  def set_order
    @order = Commercial::Order.find( params[:id] )
  end

  def order_params
    params.require(:commercial_order).permit(
      :data_do_pedido, :people_id, :valor_total,
      order_items_attributes: [:id, :product_id, :quantidade, :order_id, :_destroy],
    )
  end
end
