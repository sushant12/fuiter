# frozen_string_literal: true

class AddNameToFbPage < ActiveRecord::Migration[5.2]
  def change
    add_column :fb_pages, :name, :string
    add_column :fb_pages, :fb_page_id, :string
  end
end
