class ApplicationController < ActionController::Base
	add_flash_types :error, :info, :warning, :success

  def query_params
		query = params[:q] || {}
		Hash[query.each { |key, value| [key, value.strip] }]
	end
end
