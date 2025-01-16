class ChangePriceDataTypeInWorkOrder < ActiveRecord::Migration[8.0]
  def change
    change_column :work_orders, :price, :integer
  end
end
