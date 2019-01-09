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
    expect(fb_page.decorate.address).to eq({"city"=>"Kathmandu", "country"=>"Nepal"}
)
  end

  it 'lists albums' do
    expect(fb_page.decorate.albums).to eq([{ 'preview' =>
     'https://scontent.xx.fbcdn.net/v/t1.0-9/48275487_1175204329298695_443191920018063360_o.jpg?_nc_cat=103&_nc_ht=scontent.xx&oh=15d7a7f9edcd2b8de216163a3df50087&oe=5CC1AE08',
                                             'id' => '672955136190286',
                                             'name' => 'Timeline Photos' },
                                           { 'preview' =>
                                             'https://scontent.xx.fbcdn.net/v/t1.0-9/33751444_1020287098123753_953617842203262976_n.jpg?_nc_cat=109&_nc_ht=scontent.xx&oh=4086b041a778680c2c778566abb43d74&oe=5C91CCE8',
                                             'id' => '951034215049042',
                                             'name' => 'Mobile Uploads' },
                                           { 'preview' =>
                                             'https://scontent.xx.fbcdn.net/v/t1.0-9/19399410_843374869148311_8437031694114250167_n.png?_nc_cat=103&_nc_ht=scontent.xx&oh=4b65240fbb5cdb516e6c2eb51fa0823c&oe=5C8F6D79',
                                             'id' => '672819546203845',
                                             'name' => 'Cover Photos' },
                                           { 'preview' =>
                                             'https://scontent.xx.fbcdn.net/v/t1.0-9/19247687_843344279151370_2153541186379091213_n.png?_nc_cat=100&_nc_ht=scontent.xx&oh=f59d31045fed6a4c5c49d64df90c83e6&oe=5CCCF77B',
                                             'id' => '672830826202717',
                                             'name' => 'Profile Pictures' }])
  end

  it 'returns about section of fb page' do
    expect(fb_page.decorate.about).to eq('Grasruts makes it easy to start a crowdfunding campaign in Nepal.')
  end

  it 'returns posts of fb page' do
    expect(fb_page.decorate.posts).to eq( [{"message"=>nil,
  "image"=>"https://external.xx.fbcdn.net/safe_image.php?d=AQD1jG0Ql_MWmdx2&url=https%3A%2F%2Fi.ytimg.com%2Fvi%2Fi1tBVVanzew%2F0.jpg&_nc_hash=AQCfSYGB362e75JN",
  "created_at"=>"2019-01-05",
  "name"=>"Click here to support Encourage women travellers in Nepal organized by NepaliTravellers Collective",
  "description"=>
   "Solo Travel is a journey of creativity, courage, curiosity, and contemplation. This year, in 2018, the Solo Woman Travel Challenge, or SWO-YATRA in short, is supporting and mentoring 14 women travellers who will take on solo journeys in Nepal. This group of women is defying narratives of a soci...",
  "video"=>nil},
 {"message"=>nil,
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQCWvK53Anj-7wfo&url=https%3A%2F%2Fcdn.vox-cdn.com%2Fthumbor%2FrgDAHtmTAlMIACDP_rScnh6ajQg%3D%2F0x14%3A700x380%2Ffit-in%2F1200x630%2Fcdn.vox-cdn.com%2Fuploads%2Fchorus_asset%2Ffile%2F13644465%2F7e519fa49227e1a377ec4efd4eb534ef_original.jpg&_nc_hash=AQBkDr2YdfO4jyrl",
  "created_at"=>"2018-12-25",
  "name"=>"One Kickstarter campaign allegedly had $100,000 stolen, but still shipped its keyboards",
  "description"=>"Alleged fraud didn’t kill Keyboardio",
  "video"=>nil},
 {"message"=>nil,
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQASk7dyPPseQ9YD&url=http%3A%2F%2Fjcss-cdn.ekantipur.com%2Fthe-kathmandu-post%2Fimages%2Flogo-sm.jpg&_nc_hash=AQBoXRuuOXdWZZty",
  "created_at"=>"2018-12-23",
  "name"=>"The Post’s response to Michael Kobold’s statement on Facebook",
  "description"=>
   "The Kathmandu Post would like to respond to Mr. Michael Kobold’s recent posts on Facebook and Instagram that call attention to the Post’s reporting and accuse its editors of being corrupt.",
  "video"=>nil},
 {"message"=>
   "A year ago, when Grasruts was just starting out, we were contacted by Mr Kobold's assistant to start a crowdfunding campaign. This guy wanted to raise funds for his \"Fire truck expedition\". My whole team was so excited with their proposal.\n\nAs per our policy, we started doing some background research on Mr Kobold. Soon our excitement died after we found out that this guys was a con artist.\n\nGrasruts being a small and powerless startup, we anonymously reported a fellow reporter with potential proofs of his past activities. Finally, the dodgy man is brought to light.\n\nhttp://kathmandupost.ekantipur.com/ampnews/2018-12-20/watchmaker-promising-fire-trucks-for-nepal-has-a-series-of-dodgy-financial-dealingsand-a-chequered-past.html?__twitter_impression=true",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQDuu38okto_97yV&url=http%3A%2F%2Fassets-cdn.ekantipur.com%2Fimages%2Fthe-kathmandu-post%2Fmiscellaneous%2FKobold-20122018092214-1000x0.jpg&_nc_hash=AQDCMXuYmSRqS5uZ",
  "created_at"=>"2018-12-21",
  "name"=>"Watchmaker promising fire trucks for Nepal has a series of dodgy financial dealings—and a chequered past",
  "description"=>
   "In January last year, the Nepal Tourism Board signed an agreement to grant $200,000 to the Soarway Institute for Development for its project, the ‘Nepal Firetruck Expedition,’ an initiative to bring second-hand fire trucks donated from the United States of America to Nepal.",
  "video"=>nil},
 {"message"=>"There is certain thing that we dont have control over and there is nothing we can do about it.",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQD71i9dar3ykvqY&url=https%3A%2F%2Fcdn-images-1.medium.com%2Fmax%2F1200%2F1%2AHu8gOIDm4_epJWCGQJXBxw.jpeg&_nc_hash=AQDvBfWnPHOi0BAm",
  "created_at"=>"2018-12-15",
  "name"=>"Grasruts bags 1st Runner Up At Hult Prize – Grasruts – Medium",
  "description"=>"Hult Prize, is a challenge for young people to solve the world’s toughest issues by empowering them to make money, do good and make life…",
  "video"=>nil},
 {"message"=>nil,
  "image"=>
   "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/48275487_1175204329298695_443191920018063360_o.jpg?_nc_cat=103&_nc_ht=scontent.xx&oh=e819717b302ca481d6d1b17ba3bd605e&oe=5C95AE6A",
  "created_at"=>"2018-12-12",
  "name"=>nil,
  "description"=>nil,
  "video"=>nil},
 {"message"=>nil,
  "image"=>
   "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/45407026_610746996007715_7465213499061305344_o.png?_nc_cat=107&_nc_ht=scontent.xx&oh=af13e0ccc86b7d2d2f8ee8062703e686&oe=5CD897CC",
  "created_at"=>"2018-12-09",
  "name"=>"Sroth Code Games",
  "description"=>nil,
  "video"=>nil},
 {"message"=>"If you have not been following up on Sisan Baniya's crowdfunding campaign, here it is",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQAS5GLtkp1B3FrF&w=1280&h=720&url=https%3A%2F%2Fi.ytimg.com%2Fvi%2F9biUIVyLdqY%2Fmaxresdefault.jpg&crop&sx=0&sy=0&sw=1280&sh=720&_nc_hash=AQBkTYp44eu4Tpwv",
  "created_at"=>"2018-11-25",
  "name"=>"| Update on the Chepang Funds Collection |",
  "description"=>
   "Hello guys. We got a lot of messages about helping the chepang community. Since there aren't many people around Kailash Village to manage social programs, we...",
  "video"=>"https://www.youtube.com/embed/9biUIVyLdqY?autoplay=1"},
 {"message"=>
   "Sisan Baniya  is raising money for building a school. As per his insta story, he collected Rs 1 lakh and that is huge huge huge.\n\nHe will soon be creating a gofundme account. Do follow his insta stories to keep yourself updated.",
  "image"=>nil,
  "created_at"=>"2018-11-21",
  "name"=>nil,
  "description"=>nil,
  "video"=>nil},
 {"message"=>"We wrote a super light weight esewa library for ruby projects. #engineering",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQBBKlcDNB64yXvk&url=https%3A%2F%2Favatars0.githubusercontent.com%2Fu%2F29688249%3Fs%3D400%26v%3D4&_nc_hash=AQAjf5hUo0HobkKQ",
  "created_at"=>"2018-11-18",
  "name"=>"Grasruts/esewa",
  "description"=>"A super simple ruby client for Esewa. Contribute to Grasruts/esewa development by creating an account on GitHub.",
  "video"=>nil},
 {"message"=>"Why is Funding in Crowdfunding highly misunderstood?",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQATD9Mhbbs2y6Jn&url=https%3A%2F%2Fcdn-images-1.medium.com%2Fmax%2F1200%2F1%2Aokhatv2DUFvj_NvpJS6qDw.jpeg&_nc_hash=AQAzW1UkPhWa_8jv",
  "created_at"=>"2018-11-17",
  "name"=>"The Highly Misunderstood Part Of Crowdfunding – Grasruts – Medium",
  "description"=>"The most misunderstood part of crowdfunding is funding itself. Before I get into the why, let’s recite the definition of crowdfunding…",
  "video"=>nil},
 {"message"=>"Donors have the full right to know how their funds are being utilized, who is raising the fund  and how much they have raised.",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQA4LktwtXQrk9uP&url=https%3A%2F%2Fblogs.grasruts.com%2Fwp-content%2Fuploads%2F2018%2F02%2Flogo_insta.jpeg&_nc_hash=AQCivk-D-hqZsC9Y",
  "created_at"=>"2018-11-13",
  "name"=>"Grasruts History",
  "description"=>
   "“Whenever you’re trying to do something new in this world, if you’re trying to create any kind of meaningful change, especially change that you know will help the world, you have to expect resistance.” – Danae Ringelmann Danae Ringelmann wanted to democratize the way funds were raised and ...",
  "video"=>nil},
 {"message"=>"Nepal's very own crowdfunding platform",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQBDMnLR0Zj_LFe6&url=http%3A%2F%2Fwavemag.com.np%2Fwp-content%2Fuploads%2F2017%2F01%2Fwave_logo.png&_nc_hash=AQDT9uBFXt15lFkq",
  "created_at"=>"2018-11-08",
  "name"=>"Grasruts – Nepal’s very own Crowdfunding platform | Wave Magazine",
  "description"=>
   "Grasruts Featured Grasruts – Nepal’s very own Crowdfunding platform Venturing to build up campaigns that can fund people to overcome their financial hurdle and turn their visions, dreams and aspirations into a utopian reality. Last updated Jul 5, 2018 741 Share By Prajita Shrestha Basically, cro...",
  "video"=>nil},
 {"message"=>"We got a face lift :p\n#engineeringblog",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQA7g_V6H5kRpsak&url=https%3A%2F%2Fcdn-images-1.medium.com%2Fmax%2F800%2F1%2A8Pe7te8AEQoNzvfCy300pg.png&_nc_hash=AQC4SVrrC__VBJi3",
  "created_at"=>"2018-11-04",
  "name"=>"Writing Grasruts From Scratch.",
  "description"=>
   "For a year, Grasruts embraced Catarse, an open sourced Brazilian crowdfunding platform. It had such a nice UI and many neat features but it was a big piece of software. It could not run all of its feature in our ec2 t2.nano instance and for obvious reason we had to disable its background processing....",
  "video"=>nil},
 {"message"=>"Read this article with a grain of salt. The main takeaway from this is that you have to build a hype months before starting the campaign.",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQDf5Lj5EiRbyEgW&url=https%3A%2F%2Fcdn-images-1.medium.com%2Fmax%2F1200%2F1%2A_000TUSYGlYY3rkl8LjTgQ.gif&_nc_hash=AQDPn-EmX2o6EXUs",
  "created_at"=>"2018-10-28",
  "name"=>"I Took Advantage of the Crowdfunding Wave – Zac Park – Medium",
  "description"=>"How I generated over $2.5M on Kickstarter & Indiegogo in one year.",
  "video"=>nil},
 {"message"=>"Our new website is launched and open for beta testing.\nClick here: https://bit.ly/2D68H7T \nNote: We are still not accepting any projects.",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQDQFMkZoZts-mf_&url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fgrasruts%2Flogo_small_fb_grp.png&_nc_hash=AQBVElCoc-Roz_dS",
  "created_at"=>"2018-10-27",
  "name"=>"Grasruts | Home",
  "description"=>"Grasruts is Nepal's first legally registered crowdfunding platform. You can raise funds for ideas that you believe in.",
  "video"=>nil},
 {"message"=>"Our website will be under maintenance from today.", "image"=>nil, "created_at"=>"2018-10-14", "name"=>nil, "description"=>nil, "video"=>nil},
 {"message"=>"People have started doing the #ManjushreeTrail. Beauty of crowdfunding.\nhttps://www.youtube.com/watch?v=OLpO9UFpvK4&feature=share",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQCaxoGOvYltbUEi&w=1280&h=720&url=https%3A%2F%2Fi.ytimg.com%2Fvi%2FOLpO9UFpvK4%2Fmaxresdefault.jpg&crop&sx=0&sy=0&sw=1280&sh=720&_nc_hash=AQCTlNPMY-jVed0L",
  "created_at"=>"2018-08-31",
  "name"=>"MANJUSHREE TRAIL - Monsoon Hike around Kathmandu Valley, Namobuddha-Balthali-Godawari Section",
  "description"=>
   "This monsoon, we decided to hike the Manjushree Trail Namobuddha-Balthali-Section and it was amazing. Our trip began from Kathmandu, followed by a road trip ...",
  "video"=>"https://www.youtube.com/embed/OLpO9UFpvK4?autoplay=1"},
 {"message"=>"Grasruts wont be accepting any campaigns as of now.\nWe are upgrading our platform and servers.\n\nApologies for inconvenience.",
  "image"=>nil,
  "created_at"=>"2018-08-17",
  "name"=>nil,
  "description"=>nil,
  "video"=>nil},
 {"message"=>nil,
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQA4YGw2-iVW3JGb&url=https%3A%2F%2Fd2g8igdw686xgo.cloudfront.net%2F31608504_1532494667258286_r.jpeg&_nc_hash=AQA7yND4lMjdnSNJ",
  "created_at"=>"2018-07-26",
  "name"=>"Click here to support Help Rachana, Atoka shooting victim organized by Kapil Shrestha",
  "description"=>"नमस्कार म कपिल श्रेष्ठ। हिजो मध्यान्न १२:१५ मा ओक्लोहमाको Buddys Handy Mart ग्यासमा एक लुटेराले अन्धधुन्ध गोली बर्षाउदा स्.....",
  "video"=>nil},
 {"message"=>"https://www.b360nepal.com/innovation-insight/nonprofit-fundraising-prospects-for-a-national-crowdfunding-platform-for-nepal.html",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQCyUjQFdM7Z0FXN&url=https%3A%2F%2Fwww.b360nepal.com%2Fwp-content%2Fuploads%2F2018%2F07%2Fcrowd-funding.jpg&_nc_hash=AQCs2kt-EldF_xGV",
  "created_at"=>"2018-07-24",
  "name"=>"Nonprofit Fundraising: Prospects for a national crowdfunding platform for Nepal",
  "description"=>
   "Nonprofits in Nepal largely depend on grants provided by international development agencies and the government to fund their programs. Increase in the number of nonprofits has increased competition fo",
  "video"=>nil},
 {"message"=>
   "NPChan, an anonymous discussion board, released their source code https://bit.ly/2zcoelm.\n\nClick here to support their crowdfunding campaign https://bit.ly/2KOJH8Q",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQA_nx1N4CpMvIsH&url=https%3A%2F%2Fs3.ap-south-1.amazonaws.com%2Fjvnuploads%2Fuploads%2Fproject%2Fuploaded_image%2F48%2Fproject_thumb_facebook_NPChan_Banner.png&_nc_hash=AQDfCJxLdF8W8cSq",
  "created_at"=>"2018-07-06",
  "name"=>"Anonymous Discussion Board for Nepal (NPChan.com)",
  "description"=>"We are making Nepal's first uncensored anonymous discussion board for everyone!",
  "video"=>nil},
 {"message"=>"Grasruts turned 1 today  :)\n\nRead our short blog on what went down this year.",
  "image"=>
   "https://external.xx.fbcdn.net/safe_image.php?d=AQAU-I3tWnbXcB_z&url=http%3A%2F%2Fblogs.grasruts.com%2Fwp-content%2Fuploads%2F2018%2F06%2FDepositphotos_79104286_m-2015-660x400.jpg&_nc_hash=AQArpDHpK1qF4Rf9",
  "created_at"=>"2018-06-19",
  "name"=>"A Year Of Crowdfunding In Nepal",
  "description"=>
   "Grasruts turned one today (Jun 19, 2018) and the whole team is thrilled to have completed a year of crowdfunding in Nepal. So much has happened in this one year. We had our moments which we wished would last forever and setbacks which gave us a wake up call. But, nevertheless, we are getting a […]",
  "video"=>nil},
 {"message"=>nil,
  "image"=>
   "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/34049794_1022219724597157_1041712552066678784_n.png?_nc_cat=107&_nc_ht=scontent.xx&oh=0261a2b8ddf783db2299bafd556bba59&oe=5C9433FA",
  "created_at"=>"2018-06-01",
  "name"=>"Grasruts",
  "description"=>
   "A sheet showing our total transactions done in a year through Grasruts. We will post more stats like these on our anniversary blog (Jun 19) however I would like to request you to fill a 4 question survey that will be included in the same blog post.\n\nSurvey: https://goo.gl/forms/AqhyafgR64M2n1fU2",
  "video"=>nil},
 {"message"=>
   "A sheet showing our total transactions done in a year through Grasruts. We will post more stats like these on our anniversary blog (Jun 19) however I would like to request you to fill a 4 question survey that will be included in the same blog post.\n\nSurvey: https://goo.gl/forms/AqhyafgR64M2n1fU2",
  "image"=>
   "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/34049794_1022219724597157_1041712552066678784_n.png?_nc_cat=107&_nc_ht=scontent.xx&oh=0261a2b8ddf783db2299bafd556bba59&oe=5C9433FA",
  "created_at"=>"2018-06-01",
  "name"=>nil,
  "description"=>nil,
  "video"=>nil}])
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
