module CoreExtensions
	module Numeric
		def valor(options = {})
			number = self
			if number.present?
				precision = options[:precision]
				if precision
					options[:minimum_precision] = precision
					options[:maximum_precision] = precision
				end

				number = number.round if options[:round]
				separator = options.fetch(:separator, I18n.t('number.format.separator'))
				delimiter = options.fetch(:delimiter, I18n.t('number.format.delimiter')).to_s
				minimum_precision = options[:minimum_precision] || 0
				str = number.to_s.sub(/\.0+\z/, "")
				str =~ /\A(\-?)(\d+)(?:\.(\d+))?\z/ or raise "Could not parse number: #{number}"
				sign = $1
				integer = $2
				fraction = ($3 || '')
				floor = $4

				if options[:maximum_precision]
					fraction = fraction[0, options[:maximum_precision]] if options[:maximum_precision]
				end

				if minimum_precision > 0
					if fraction.length > 0 || minimum_precision > 0
						fraction = "#{fraction}#{'0' * [0, minimum_precision - fraction.length].max}"
					end
				end

				# the following two lines appear to be the most performant way to add a delimiter to every thousands place in the number
				integer_size = integer.size
				(1..((integer_size-1) / 3)).each {|x| integer[integer_size-x*3,0] = delimiter}
				str = integer.chomp(delimiter)

				# add fraction
				str << "#{separator}#{fraction}" if fraction.length > 0

				# restore sign
				str = "#{sign}#{str}"
				# add unit if given
				if options[:unit]
					unless options[:unit_separator] == false
						str.prepend options.fetch(:unit_separator, " ")
					end
					str.prepend options[:unit]
				end
				str
			end
		end

		def valor_relatorios(options = {})
				valor(options.reverse_merge(minimum_precision: 2, maximum_precision: 4, separator: "."))
		end

		def valor_financeiro(options = {})
			valor(options.reverse_merge(unit: 'R$', minimum_precision: 2, maximum_precision: 4))
		end

		def valor_contabil(options = {})
			valor(options.reverse_merge(minimum_precision: 2))
		end

		def cap_at limit
			[self, limit].min
		end

		def to_whole
			self.negative? ? 0 : self.to_i
		end
	end
end
