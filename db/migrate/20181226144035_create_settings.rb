class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings,  id: :uuid do |t|
      t.jsonb :socail_media
      t.jsonb :legal_info
      t.string :domain
      t.timestamps
      t.references :templates, foreign_key: true, type: :uuid, index: true
    end
  end
end
