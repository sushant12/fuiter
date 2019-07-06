class AddSubscribeToFbPageTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :subscribed, :boolean, default: false
  end
end
