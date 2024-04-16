class CreateShoes < ActiveRecord::Migration[7.1]
  def change
    create_table :shoes do |t|
      t.string :shoe_model
      t.string :shoe_type
      t.integer :quantity_available
      t.string :gender
      t.string :size
      t.string :color
      t.string :material
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
