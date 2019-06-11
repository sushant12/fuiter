class AddTrialToFbPageTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_page_templates, :trial, :boolean
  end
end
