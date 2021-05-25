class CreateWebAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :web_addresses do |t|
      t.string :title
      t.text :full_url
      t.string :short_url

      t.timestamps
    end
  end
end
