class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions,  id: :uuid do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.datetime :due_date
      t.timestamps
      t.references :fb_pages, foreign_key: true, type: :uuid, index: true
    end
    execute <<-SQL
      CREATE TYPE subscription_type AS ENUM ('monthly', 'yearly');
    SQL
    add_column :subscriptions, :category, :subscription_type
  end

  def down
    remove_column :subscriptions, :category
    execute <<-SQL
      DROP TYPE subscription_type;
    SQL
  end
end
