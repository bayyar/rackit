class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.string :image
      t.boolean :is_primary
      t.timestamps
    end
  end
end
