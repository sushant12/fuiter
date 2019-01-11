# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :image
      t.string :token
      t.timestamps
    end

    execute <<-SQL
        CREATE TYPE user_category AS ENUM ('normal', 'reseller', 'admin');
    SQL
    add_column :users, :category, :user_category
  end

  def down
    remove_column :users, :category
    execute <<-SQL
      DROP TYPE user_category;
    SQL
  end
end
