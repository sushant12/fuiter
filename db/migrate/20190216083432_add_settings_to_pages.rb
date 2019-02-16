class AddSettingsToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :setting, :jsonb
  end
end
