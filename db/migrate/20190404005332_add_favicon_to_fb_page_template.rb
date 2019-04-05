class AddFaviconToFbPageTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :favicon, :string
  end
end
