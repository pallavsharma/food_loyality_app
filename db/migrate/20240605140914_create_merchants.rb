class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :username
      t.string :email
      t.string :businessname
      t.text :qr_code_url
      t.text :image_url
      t.text :video_url
      t.string :address
      t.string :location
      t.json :metadata

      t.timestamps
    end
  end
end
