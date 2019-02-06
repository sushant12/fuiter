class AddPagesToFbPageTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :pages, :jsonb
  end
end
