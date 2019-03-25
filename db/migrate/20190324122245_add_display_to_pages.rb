class AddDisplayToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :display, :boolean, default: true
  end
end
