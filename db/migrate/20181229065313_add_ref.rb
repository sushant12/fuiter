# frozen_string_literal: true

class AddRef < ActiveRecord::Migration[5.2]
  def change
    add_reference :settings, :fb_page_template, type: :uuid, foreign_key: true, index: true
    add_reference :pages, :fb_page_template, type: :uuid, foreign_key: true, index: true
  end
end
