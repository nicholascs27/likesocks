module CoreExtensions
	module Float
		def formato_decimal
			format("%.2f", self).gsub(".", ",")
		end

		def prettify
			to_i == self ? to_i : self
		end
	end
end
