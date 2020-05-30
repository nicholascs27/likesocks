module CoreExtensions
	module Integer
		def digitos(tamanho_minimo_da_string)
			self.to_s.rjust(tamanho_minimo_da_string, '0')
		end
	end
end
