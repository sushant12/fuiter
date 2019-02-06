# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ListFbPages', type: :request do
  let(:user)             { create :user                                                                           }
  let(:template)         { create :template                                                                       }
  let(:fb_page)          { create :fb_page, content: JSON.parse(file_fixture('page.json').read), user_id: user.id }
  let(:fb_page_template) { create :fb_page_template, fb_page_id: fb_page.id, template_id: template.id             }
  let(:page)             { create :page, fb_page_template_id: fb_page_template.id }

  before do
    user
    template
    fb_page
    fb_page_template
    page
  end

  describe 'GET /' do
    it 'Lists user fb pages' do
      sign_in user
      get '/'
      expect(response.body).to include('test')
    end
  end
end