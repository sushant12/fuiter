# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Templates', type: :request do
  let(:user)             { create :user                                                                           }
  let(:template)         { create :template                                                                       }
  let(:fb_page)          { create :fb_page, content: JSON.parse(file_fixture('page.json').read), user_id: user.id }

  before do
    user
    template
    fb_page
  end

  describe 'POST choose_template' do
    it 'chooses template' do
      sign_in user
      post choose_template_path(fb_page.id, template.id)
      expect(response).to redirect_to(editor_design_path(fb_page.id))
    end
  end
end
