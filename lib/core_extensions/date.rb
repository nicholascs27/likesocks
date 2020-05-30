module CoreExtensions
	module Date
		def sim_data
			self.strftime("%Y%m%d") unless self.nil?
		end
	end
end
