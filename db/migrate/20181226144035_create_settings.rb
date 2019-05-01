# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings, id: :uuid do |t|
      t.jsonb :social_media, default: {}
      t.jsonb :legal_info, default: {}
      t.string :domain
      t.timestamps
    end
  end
end
