ActiveAdmin.register Template do
  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  index do
    column :name
    column :status
    column :category
    column :fb_page_id
    actions
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

