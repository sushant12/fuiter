class AddFbMessengerToSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :fb_messenger, :boolean, default: true
  end
end
