class AddAncestryToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :ancestry, :string
    add_index :pages, :ancestry
  end
end
