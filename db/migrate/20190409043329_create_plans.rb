class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans, id: :uuid do |t|
      t.string :payment_gateway_plan_id
      t.string :name
      t.decimal :price
      t.integer :interval
      t.integer :interval_count
      t.integer :status
      t.text :description

      t.timestamps
    end
  end
end
