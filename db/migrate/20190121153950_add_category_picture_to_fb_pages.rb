class AddCategoryPictureToFbPages < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_pages, :category, :string
    add_column :fb_pages, :picture, :string
  end
end
