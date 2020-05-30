class Base::ProductModelsController < SiteController

	before_action :set_product_model, except: [:index, :new, :create]

	def index
		@q = Base::ProductModel.ransack(params[:q])
		@product_models = @q.result(distinct: false)
	end

	def new
		@product_model = Base::ProductModel.new
	end

	def create
		@product_model = Base::ProductModel.new(product_model_params)

		if @product_model.save
			redirect_to base_product_models_path, success: "Modelo cadastrado com sucesso"
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @product_model.update(product_model_params)
			redirect_to base_product_models_path, success: "Modelo atualizado com sucesso"
		else
			render :edit
		end
	end

	def destroy
		begin
			if @product_model.destroy
				redirect_to base_product_models_path, success: "Modelo apagado com sucesso"
			else
				redirect_to base_product_models_path, alert: "Não foi possível deletar o registro"
			end
		rescue ActiveRecord::RecordNotDestroyed => e
			redirect_to base_product_models_path, alert: "Não foi possível deletar o registro"
		rescue ActiveRecord::DeleteRestrictionError => e
			redirect_to base_product_models_path, alert: "Não foi possível excluir, pois existem dependências que impedem o registro de ser apagado."
		rescue Exception => e
			mensagem = {alert: 'Erro ao excluir registro'}
		end
	end

	private

	def set_product_model
		@product_model = Base::ProductModel.find( params[:id] )
	end

	def product_model_params
		params.require(:base_product_model).permit(:descricao)
	end
end
