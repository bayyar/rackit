require 'fileutils'
require 'csv'

class BrandSeeds

	def self.seed_brands
    FileUtils.rm_rf("#{Rails.root}/public/uploads/brands")
    Brand.destroy_all
    Brand.create([
                   { name: '7 for all Mankind'}, { name: 'Aquashift'}, { name: 'Celine'},
                   { name: 'Donna Karan'}, { name: 'Gap'}, { name: 'H&M'},
                   { name: 'GUESS'}, { name: 'Calvin Klein'}, { name: 'Forever 21'}
    ])
  end

  def self.seed_brands_csv
    FileUtils.rm_rf("#{Rails.root}/public/uploads/brands")
    Brand.destroy_all
    file = File.join(Rails.root,'spec','files','csv','products.csv')
    CSV.foreach(file, headers: true, col_sep: ",") do |row|
      Brand.find_or_create_by!(
    		name: row['MANUFACTURER']
    		)
    end
  end

end