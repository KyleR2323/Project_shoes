class RenameItemPriceToPrice < ActiveRecord::Migration[7.1]
  def change
    rename_column :order_items, :item_price, :price
  end
end
