namespace :import do

	require 'csv'

	@technicians_fpath= "#{ Rails.root }/lib/assets/technicians.csv"
	@locations_fpath= "#{ Rails.root }/lib/assets/locations.csv"
	@work_order_fpath= "#{ Rails.root }/lib/assets/work_orders.csv"

	# row[0] returns a record's id, but not row['id'] for some reason
	ID_IDX = 0

	desc "Easy import for everything"
	task :all => [ :technicians, :locations, :work_orders  ]

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

	desc "Import or update location records from file"
	task locations: :environment do
		sheet = CSV.parse(File.read(@locations_fpath), :headers => true)
		sheet.each do |row|

			record = Location.find_by(id: row[ID_IDX])

			if record.blank?
				record = Location.new
			end

			record.id = row[ID_IDX]
			record.name = row['name']
			record.city = row['city']

			if record.save!
				pp record
			else
				throw("Issue saving record: #{ record.to_s }")
			end
		end
	end

	desc "Import or update work orders records from file"
	task work_orders: :environment do
		sheet = CSV.parse(File.read(@work_order_fpath), :headers => true)
		sheet.each do |row|

			record = WorkOrder.find_by(id: row[ID_IDX])

			if record.blank?
				record = WorkOrder.new
			end

			record.id = row[ID_IDX]
			record.technician_id = row['technician_id']
			record.location_id = row['location_id']
			record.time = DateTime.strptime(row['time'], '%d/%m/%y %k:%M')
			record.duration = row['duration']
			record.price = row['price']

			if record.save!
				pp record
			else
				throw("Issue saving record: #{ record.to_s }")
			end
		end
	end
end