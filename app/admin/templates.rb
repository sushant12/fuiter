# frozen_string_literal: true

ActiveAdmin.register Template do
  json_editor

  index do
    column :name
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :image do |model|
        image_tag(model.image)
      end
      row :property do |model|
        pre(JSON.pretty_generate(model.properties))
      end
    end
  end

  permit_params :name, :image, :properties

  form title: 'Update Template' do |_f|
    inputs 'Details' do
      input :name
      input :image
      input :properties, as: :jsonb
    end

    para 'Press cancel to return to the list without saving.'
    actions
  end
end
