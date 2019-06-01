class AddPgSubscriptionIdToFbPageTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :payment_gateway_subscription_id, :string
  end
end
