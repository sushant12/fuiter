class UpdateStatusOfFbPage < ActiveRecord::Migration[5.2]
  def change
    remove_column :fb_pages, :status
    execute <<-SQL
      CREATE TYPE fb_page_status AS ENUM ('online', 'in progress', 'expired');
    SQL
    add_column :fb_pages, :status, :fb_page_status
    add_index :fb_pages, :status
  end

  def down
    remove_column :fb_pages, :status
    execute <<-SQL
      DROP TYPE fb_page_status;
    SQL
  end
end
