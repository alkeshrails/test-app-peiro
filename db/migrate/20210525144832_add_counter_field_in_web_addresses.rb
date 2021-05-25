class AddCounterFieldInWebAddresses < ActiveRecord::Migration[6.1]
  def change
  	add_column :web_addresses, :visiting_count, :bigint
  end
end
