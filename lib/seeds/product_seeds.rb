require 'fileutils'
require 'open-uri'
require 'csv'

class ProductSeeds

  def self.seed_products
    FileUtils.rm_rf("#{Rails.root}/public/uploads/products")
    Product.destroy_all
    100.times do
      p = Product.new(name: Faker::Commerce.product_name, price: 100, brand_id: Brand.offset(rand(Brand.count)).first.id)
      if p.save
        Product::Image.create(product_id: p.id, image: File.open("#{Rails.root}/spec/files/lady-in-dress.jpg"), is_primary: true)
      end
    end
  end

  def self.seed_products_csv
    FileUtils.rm_rf("#{Rails.root}/public/uploads/products")
    Product.destroy_all
    Product::Image.destroy_all
    file = File.join(Rails.root,'spec','files','csv','products.csv')
    CSV.foreach(file, headers: true, col_sep: ",", skip_blanks: true) do |row|
          brand = Brand.where(name: row['MANUFACTURER']).first
          if row['IS_PRIMARY'] == "1"
            p = Product.new(
              name: row['NAME'],
              price: row['PRODUCT_PRICE'],
              description: row['DESCRIPTION'],
              buy_url: row['BUYURL'],
              brand_id: brand.id
              )
            if p.save
              open("image.jpg", "wb") do |image|
                url = URI.escape("#{row['IMAGEURL']}")
                image << open(url).read
                Product::Image.create(product_id: p.id, image: File.open(image), is_primary: true)
              end
            end
          else
            p = Product.where(name: row['NAME']).first
            open("image.jpg", "wb") do |image|
              url = URI.escape("#{row['IMAGEURL']}")
              image << open(url).read
              Product::Image.create(product_id: p.id, image: File.open(image), is_primary: false)
            end
          end
    end
  end

end
