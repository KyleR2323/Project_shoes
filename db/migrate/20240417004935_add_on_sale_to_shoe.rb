class AddOnSaleToShoe < ActiveRecord::Migration[7.1]
  def change
    add_column :shoes, :on_sale, :boolean
  end
end
