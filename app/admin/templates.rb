ActiveAdmin.register Template do

  index do
    column :name
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :source_json do |model|
        pre(JSON.pretty_generate(model.properties))
      end
    end
  end
  
  # permit_params :name, :email, :password, :admin

  # form title: 'User Registration' do |f|
  #   inputs 'Details' do
  #     input :name
  #     input :email
  #     input :password
  #     input :admin, as: :boolean
  #   end

  #   para "Press cancel to return to the list without saving."
  #   actions
  # end
end

