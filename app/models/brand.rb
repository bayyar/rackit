class Brand < ActiveRecord::Base

mount_uploader :logo, BrandUploader
has_many :products, dependent: :destroy

end