class AddSubdomainToSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :subdomain, :string
  end
end
