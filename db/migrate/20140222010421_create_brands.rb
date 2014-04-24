class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
    	t.string :name
    	t.string :description
    	t.string :url
    	t.string :logo
      t.timestamps
    end
  end
end
