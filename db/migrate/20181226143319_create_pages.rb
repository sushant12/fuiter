# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages, id: :uuid do |t|
      t.string :title
      t.integer :position
      t.jsonb :seo
      t.timestamps
    end
  end
end
