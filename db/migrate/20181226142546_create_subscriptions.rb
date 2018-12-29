class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions,  id: :uuid do |t|
      # t.enum :status [:yearly, :monthly]
      t.decimal :amount, :precision => 8, :scale => 2
      t.datetime :due_date
      t.timestamps
      t.references :fb_pages, foreign_key: true, type: :uuid, index: true
    end
  end
end
