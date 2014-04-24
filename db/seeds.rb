require 'csv'
require 'open-uri'

Dir[Rails.root.join("lib/seeds/**/*.rb")].each {|f| require f}
BrandSeeds.seed_brands_csv
ProductSeeds.seed_products_csv