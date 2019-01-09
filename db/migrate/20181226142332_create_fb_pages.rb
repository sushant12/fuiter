# frozen_string_literal: true

class CreateFbPages < ActiveRecord::Migration[5.2]
  def change
    create_table :fb_pages, id: :uuid do |t|
      t.string :token
      t.jsonb :content
      t.boolean :status, default: false
      t.string :sub_domain
      t.timestamps
      t.references :user, foreign_key: true, type: :uuid, index: true
    end
  end
end
