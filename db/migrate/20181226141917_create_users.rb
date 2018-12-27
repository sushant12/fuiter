class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :image
      t.string :token
      # t.column :status, "ENUM('normal', 'reseller')"
      t.timestamps
    end
  end
end
