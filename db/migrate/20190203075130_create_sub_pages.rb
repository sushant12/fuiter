class CreateSubPages < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_pages do |t|
      t.uuid :sub_page_id
      t.timestamps
    end
    add_reference :sub_pages, :page, type: :uuid, foreign_key: true, index: true
  end
end
