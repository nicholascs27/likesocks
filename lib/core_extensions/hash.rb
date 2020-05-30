module CoreExtensions
	module Hash
		def formatar
			self.values.join('.')
		end

		def formatar_sem_pontos
			self.values.join
		end
	end
end
