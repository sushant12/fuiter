class AddContactToFbPageTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :email, :string
    add_column :fb_page_templates, :location, :string
    add_column :fb_page_templates, :contact, :string
    add_column :fb_page_templates, :email_enable, :boolean
    add_column :fb_page_templates, :location_enable, :boolean
    add_column :fb_page_templates, :contact_enable, :boolean
    add_column :fb_page_templates, :map_enable, :boolean
  end
end
