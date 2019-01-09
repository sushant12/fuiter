# frozen_string_literal: true

class AddUriToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :uri, :string
  end
end
