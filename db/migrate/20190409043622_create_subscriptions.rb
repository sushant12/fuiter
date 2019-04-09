class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.string :payment_gateway
      t.string :payment_gateway_subscription_id
      t.references :fb_page, type: :uuid, foreign_key: true, index: true
      t.references :plan, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
