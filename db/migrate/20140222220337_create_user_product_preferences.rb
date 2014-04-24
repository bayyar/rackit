class CreateUserProductPreferences < ActiveRecord::Migration
  def change
    create_table :user_product_preferences do |t|
      t.integer :user_id
      t.integer :product_id
      t.boolean :preference, default: false
      t.timestamps
    end
    add_index :user_product_preferences, [:user_id, :product_id]
  end
end
