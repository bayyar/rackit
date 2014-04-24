class ChangeBuyUrlInProductTableFromStringToText < ActiveRecord::Migration
  def change
  	change_column :products, :buy_url, :text
  end
end
