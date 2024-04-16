class CreateSalePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :sale_prices do |t|
      t.decimal :sale_price
      t.date :sale_date
      t.string :sale_item

      t.timestamps
    end
  end
end
