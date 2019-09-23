# frozen_string_literal: true

ActiveAdmin.register FbPage do
  config.clear_action_items!

  filter :subscriptions
  filter :fb_page_template
  filter :user
  filter :sub_domain
  filter :created_at
  filter :updated_at
  filter :name
  filter :fb_page
  filter :status, as: :select, collection: FbPage.statuses
  filter :category

  index do
    column :name
    column :status
    column :category
    column :fb_page_id
    column :sub_domain
    actions
  end

  permit_params :name, :status, :category, :fb_page_id,
                fb_page_template_attributes: %i[id subscribed]

  form title: 'Facebook page form' do |f|
    # binding.pry
    inputs 'Details' do
      input :name
      input :status, as: :select, collection: FbPage.statuses
      input :category
      # input :subscribed
    end

    # f.inputs "subscribed" do

    f.has_many :fb_page_template, new_record: false, allow_destroy: false do |k|
      k.input :subscribed, as: :boolean
    end
    # end

    para 'Press cancel to return to the list without saving.'
    actions
  end
end
