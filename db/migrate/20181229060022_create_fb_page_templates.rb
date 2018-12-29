class CreateFbPageTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :fb_page_templates,  id: :uuid do |t|
      t.jsonb :properties
      t.references :fb_pages, type: :uuid, foreign_key: true, index: true
      t.references :templates, type: :uuid, foreign_key: true, index: true
      t.timestamps
    end
  end
end
