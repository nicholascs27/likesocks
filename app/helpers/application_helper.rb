module ApplicationHelper

  def errors_for(object)
		if object.errors.any?
			content_tag(:div, class: "panel panel-danger") do
				concat(content_tag(:div, class: "panel-heading") do
					concat(content_tag(:h4, class: "panel-title") do
						concat "#{pluralize(object.errors.count, "erro")} encontrado(s):"
					end)
				end)
				concat(content_tag(:div, class: "panel-body") do
					concat(content_tag(:ul) do
						object.errors.full_messages.each do |msg|
							concat content_tag(:li, msg)
						end
					end)
				end)
			end
		end
	end

	def error_for(model, *attributes)
		return if model.nil?
		mensagem = []
		attributes.each do |attribute|
			model.errors[attribute].each do |error|
				if mensagem.exclude? error
					mensagem << error
				end
			end
		end

		content_tag :span, class: 'error_explanation' do
			mensagem.join(', ')
		end
	end
end
