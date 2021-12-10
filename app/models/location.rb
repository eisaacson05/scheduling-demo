class Location < ApplicationRecord

	def pretty
		"#{ name }, #{ city }"
	end
end
