class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates, id: :uuid do |t|
      t.string :name
      t.string :image
      t.jsonb  :properties
      t.timestamps
    end
  end
end
