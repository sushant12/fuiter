class AddTitleToFbPageTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :title, :string
  end
end
