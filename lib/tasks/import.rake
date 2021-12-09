namespace :import do

	require 'csv'

	@technicians_fpath= "#{ Rails.root }/lib/assets/technicians.csv"
	@locations_fpath= "#{ Rails.root }/lib/assets/locations.csv"
	@work_order_fpath= "#{ Rails.root }/lib/assets/work_orders.csv"

	# row[0] returns a record's id, but not row['id'] for some reason
	ID_IDX = 0

	desc "Import or update technician records from file"
	task technicians: :environment do
		sheet = CSV.parse(File.read(@technicians_fpath), :headers => true)
		sheet.each do |row|

			record = Technician.find_by(id: row[ID_IDX])

			if record.blank?
				record = Technician.new
			end

			record.id = row[ID_IDX]
			record.name = row['name']

			if record.save!
				pp record
			else
				throw("Issue saving record: #{ record.to_s }")
			end
		end
	end
end