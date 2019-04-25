# frozen_string_literal: true

class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates, id: :uuid do |t|
      t.string :name
      t.string :image
      t.jsonb  :properties, default: {}
      t.timestamps
    end
  end
end
