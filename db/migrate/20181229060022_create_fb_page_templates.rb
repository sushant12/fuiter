# frozen_string_literal: true

class CreateFbPageTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :fb_page_templates, id: :uuid do |t|
      t.jsonb :properties, default: {}
      t.references :fb_page, type: :uuid, foreign_key: true, index: true
      t.references :template, type: :uuid, foreign_key: true, index: true
      t.timestamps
    end
  end
end
