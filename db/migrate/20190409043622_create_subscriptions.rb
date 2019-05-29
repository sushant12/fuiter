class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.integer :payment_gateway
      t.string :payment_gateway_subscription_id
      t.jsonb :meta_data
      t.references :fb_page_template, type: :uuid, foreign_key: true, index: true
      t.references :user, type: :uuid, foreign_key: true, index: true
      t.timestamps
    end
  end
end
