class Product::Image < ActiveRecord::Base

mount_uploader :image, Product::ImageUploader

belongs_to :Product


end
