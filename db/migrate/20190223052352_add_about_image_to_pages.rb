class AddAboutImageToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :about_image, :string
  end
end
