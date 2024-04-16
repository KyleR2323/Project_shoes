class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.decimal :total_amount
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst
      t.decimal :subtotal

      t.timestamps
    end
  end
end
