class Base::ProductsController < SiteController

  before_action :set_product, except: [:index, :new, :create]
  before_action :disponibiliza_dependencias, only: [:new, :edit]

  def index
    @q = Base::Product.ransack(params[:q])
    @products = @q.result(distinct: false)
  end

  def new
    @product = Base::Product.new
  end

  def create
    @product = Base::Product.new(product_params)

    if @product.save
      redirect_to base_products_path, success: "Produto cadastrado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      # redirect_to @product, notice: "Produto atualizado com sucesso"
      redirect_to base_products_path, success: "Produto atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to base_products_path, success: "Produto apagado com sucesso"
    else
      redirect_to base_products_path, alert: "Não foi possível deletar o registro"
    end
  end

  private

  def disponibiliza_dependencias
    @modelos = Base::ProductModel.all.order(:id)
  end

  def set_product
    @product = Base::Product.find(params[:id])
  end

  def product_params
    params.require(:base_product).permit(:descricao, :product_model_id, :preco,
      :quantidade_estoque, :quantidade_estoque_minimo, :imagem
    )
  end

end
