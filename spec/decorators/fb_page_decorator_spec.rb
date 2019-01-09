# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FbPageDecorator do
  let(:user)             { create :user                                                                           }
  let(:template)         { create :template                                                                       }
  let(:fb_page)          { create :fb_page, content: JSON.parse(file_fixture('page.json').read), user_id: user.id }
  let(:fb_page_template) { create :fb_page_template, fb_page_id: fb_page.id, template_id: template.id             }
  let(:page)             { create :page, fb_page_template_id: fb_page_template.id                                 }

  let(:no_album_fb_page) { create :fb_page, content: JSON.parse(file_fixture('no_album_page.json').read), user_id: user.id }
  let(:no_album_fb_page_template) { create :fb_page_template, fb_page_id: no_album_fb_page.id, template_id: template.id }
  let(:no_album_page)             { create :page, fb_page_template_id: no_album_fb_page_template.id                     }

  before do
    user
    template
    fb_page
    fb_page_template
    page
    no_album_fb_page
    no_album_fb_page_template
    no_album_page
  end

  it 'prints menu' do
    expect(fb_page.decorate.menu).to eq([{ 'name' => 'Home', 'uri' => 'home' }])
  end

  it 'returns fb cover images' do
    expect(fb_page.decorate.cover_images).to eq([{ 'width' => 820,
                                                   'height' => 312,
                                                   'source' =>
   'https://scontent.xx.fbcdn.net/v/t1.0-9/19399410_843374869148311_8437031694114250167_n.png?_nc_cat=103&_nc_ht=scontent.xx&oh=4b65240fbb5cdb516e6c2eb51fa0823c&oe=5C8F6D79' },
                                                 { 'width' => 2860,
                                                   'height' => 1280,
                                                   'source' =>
                                                   'https://scontent.xx.fbcdn.net/v/t31.0-8/19400552_843346729151125_5620538260761663852_o.jpg?_nc_cat=111&_nc_ht=scontent.xx&oh=9d011103ef08fe0433007a4bea9e8416&oe=5C950246' }])
  end

  it 'returns default cover images' do
    expect(no_album_fb_page.decorate.cover_images).to eq([{ 'source' => 'https://via.placeholder.com/728x90.png?text=Visit+WhoIsHostingThis' }, { 'source' => 'https://via.placeholder.com/728x90.png' }])
  end

  it 'returns fb page name' do
    expect(fb_page.decorate.name).to eq('Grasruts')
  end

  it 'returns fb page address' do
    expect(fb_page.decorate.address).to eq('zip' => '977', 'city' => 'Kathmandu', 'country' => 'Nepal')
  end

  it 'lists albums' do
    expect(fb_page.decorate.albums).to eq([{ 'album_photos' =>
     'https://scontent.xx.fbcdn.net/v/t1.0-9/48275487_1175204329298695_443191920018063360_o.jpg?_nc_cat=103&_nc_ht=scontent.xx&oh=15d7a7f9edcd2b8de216163a3df50087&oe=5CC1AE08',
                                             'album_id' => '672955136190286',
                                             'album_name' => 'Timeline Photos' },
                                           { 'album_photos' =>
                                             'https://scontent.xx.fbcdn.net/v/t1.0-9/33751444_1020287098123753_953617842203262976_n.jpg?_nc_cat=109&_nc_ht=scontent.xx&oh=4086b041a778680c2c778566abb43d74&oe=5C91CCE8',
                                             'album_id' => '951034215049042',
                                             'album_name' => 'Mobile Uploads' },
                                           { 'album_photos' =>
                                             'https://scontent.xx.fbcdn.net/v/t1.0-9/19399410_843374869148311_8437031694114250167_n.png?_nc_cat=103&_nc_ht=scontent.xx&oh=4b65240fbb5cdb516e6c2eb51fa0823c&oe=5C8F6D79',
                                             'album_id' => '672819546203845',
                                             'album_name' => 'Cover Photos' },
                                           { 'album_photos' =>
                                             'https://scontent.xx.fbcdn.net/v/t1.0-9/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=f59d31045fed6a4c5c49d64df90c83e6&oe=5CCCF77B',
                                             'album_id' => '672830826202717',
                                             'album_name' => 'Profile Pictures' }])
  end

  it 'returns about section of fb page' do
    expect(fb_page.decorate.about).to eq('Grasruts makes it easy to start a crowdfunding campaign in Nepal.')
  end

  it 'returns posts of fb page' do
    # binding.pry
    # expect(fb_page.decorate.posts).to eq("Grasruts makes it easy to start a crowdfunding campaign in Nepal.")
  end

  it 'returns events of fb page' do
    # expect(fb_page.decorate.events).to eq("Grasruts makes it easy to start a crowdfunding campaign in Nepal.")
  end

  it 'returns description of the fb page' do
    expect(fb_page.decorate.description).to eq('The intent to roll out creative ventures to the public, lend a helping hand during tough times or many more personal and social causes have shown that the community is bounded by something positive to hold onto. The potential is huge to strengthen this community and Grasruts works for it.')
  end

  it 'returns photos of the fb page' do
    expect(fb_page.decorate.photos('672830826202717')).to eq([[{ 'width' => 618,
                                                                 'height' => 618,
                                                                 'source' =>
    'https://scontent.xx.fbcdn.net/v/t1.0-9/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=f59d31045fed6a4c5c49d64df90c83e6&oe=5CCCF77B' },
                                                               { 'width' => 600,
                                                                 'height' => 600,
                                                                 'source' =>
                                                                 'https://scontent.xx.fbcdn.net/v/t1.0-0/p600x600/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=83ec0b22616822e5bbc3cc4888f3cc58&oe=5CC0F020' },
                                                               { 'width' => 480,
                                                                 'height' => 480,
                                                                 'source' =>
                                                                 'https://scontent.xx.fbcdn.net/v/t1.0-0/p480x480/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=895a982057035228f632483804b40f6b&oe=5CCA09C0' },
                                                               { 'width' => 320,
                                                                 'height' => 320,
                                                                 'source' =>
                                                                 'https://scontent.xx.fbcdn.net/v/t1.0-0/p320x320/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=25139a5cc790f984b78ca91a98657d1b&oe=5C8CFA9A' },
                                                               { 'width' => 540,
                                                                 'height' => 540,
                                                                 'source' =>
                                                                 'https://scontent.xx.fbcdn.net/v/t1.0-0/p180x540/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=d622cea773b9ce863fe1f6d8c083db57&oe=5C93CB27' },
                                                               { 'width' => 130,
                                                                 'height' => 130,
                                                                 'source' =>
                                                                 'https://scontent.xx.fbcdn.net/v/t1.0-0/p130x130/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=18a4d23f6cf6c50a0aeb4f5c9c82cae8&oe=5CC59AF5' },
                                                               { 'width' => 225,
                                                                 'height' => 225,
                                                                 'source' =>
                                                                 'https://scontent.xx.fbcdn.net/v/t1.0-0/p75x225/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=99c0289e804dbc94274380ee3eee284e&oe=5C941981' }]])
  end
end
