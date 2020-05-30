module CoreExtensions
	module String
		def numeric?
			return true if self =~ /\A\d+\Z/
		end

		def to_underscore
			self.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').
			tr("- ", "_").tr("çÇ", "c").tr("ãÃáÁàÀ", "a").
			downcase
		end

		def formatado_como_classificacao_da_despesa
			self.gsub(/(\d{1})(\d{1})(\d{2})(\d{2})(\d{2})/, '\1.\2.\3.\4.\5')
		end

		def sim_txt
			self.upcase
		end

		def sim_limite(numero, apendice="")
			if self.strip.length > numero.to_i
				'"' + I18n.transliterate(self.strip[0..(numero - 1)]) + apendice + '"'
			else
				'"' + I18n.transliterate(self) + apendice + '"'
			end
		end

		def sim_preenche(numero)
			if self.strip.length > numero.to_i
				'"' + I18n.transliterate(self.strip[0..(numero - 1)]) + '"'
			elsif self.strip.length < numero.to_i
				'"' + I18n.transliterate(self.strip.rjust(numero, '0')) + '"'
			else
				'"' + I18n.transliterate(self) + '"'
			end
		end

		def sim_valor
			format("%.2f", self) unless self.empty?
		end

		def as_cpf
			if self.to_s.strip.length == 11
				p1, p2, p3, p4 = self.match(/(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/i).captures
				formatado = "#{p1}.#{p2}.#{p3}-#{p4}"
			else
				formatado = self
			end
		end

		def as_cnpj
			if self.to_s.strip.length == 14
				p1, p2, p3, p4, p5 = self.match(/(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/i).captures
				formatado = "#{p1}.#{p2}.#{p3}/#{p4}-#{p5}"
			else
				formatado = self
			end
		end

		def as_telefone
			if self.to_s.strip.length == 10
				p1, p2, p3 = self.match(/(\d{2})\.?(\d{4})\.?(\d{4})/i).captures
				formatado = "(#{p1}) #{p2}-#{p3}"
			elsif self.to_s.strip.length == 11
				p1, p2, p3 = self.match(/(\d{2})\.?(\d{5})\.?(\d{4})/i).captures
				formatado = "(#{p1}) #{p2}-#{p3}"
			else
				formatado = self
			end
		end

		def as_cep
			if self.to_s.strip.length == 8
				p1, p2 = self.match(/(\d{5})\-?(\d{3})/i).captures
				formatado = "#{p1}-#{p2}"
			else
				formatado = self
			end
		end
	end
end
