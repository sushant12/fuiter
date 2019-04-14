ActiveAdmin.register FbPage do
  config.clear_action_items!

  filter :subscriptions
  filter :fb_page_template
  filter :user
  filter :token
  filter :sub_domain
  filter :created_at
  filter :updated_at
  filter :name
  filter :fb_page
  filter :status, as: :select, collection: FbPage.statuses
  filter :category
  filter :picture

  index do
    column :name
    column :status
    column :category
    column :fb_page_id
    actions
  end

  permit_params :name, :status, :category, :fb_page_id

  form title: 'Facebook page form' do |f|
    inputs 'Details' do
      input :name
      input :status, as: :select, collection: FbPage.statuses
      input :category
      input :fb_page_id
    end

    para "Press cancel to return to the list without saving."
    actions
  end
end
