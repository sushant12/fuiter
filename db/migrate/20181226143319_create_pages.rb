class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages,  id: :uuid do |t|
      t.string :title
      t.integer :position
      # t.enum :status [:yearly, :monthly]
      t.jsonb :seo
      t.timestamps
      t.references :templates, foreign_key: true, type: :uuid
    end
  end
end
