class AddBuyUrLtoProductTable < ActiveRecord::Migration
  def change
  	add_column :products, :buy_url, :string
  end
end
