# frozen_string_literal: true

namespace :templates do
  desc 'add local template info into db'
  task sync: :environment do
    base_dir = Rails.root.join('app', 'views', 'templates')
    Dir.chdir(base_dir)
    Dir.glob('*').each do |dir|
      next unless File.directory? dir

      config = "#{base_dir}/#{dir}/fuitter.json"
      metadata = JSON.parse(File.read(config))
      t = Template.find_or_initialize_by(name: metadata['name'])
      t.name = metadata['name']
      t.image = metadata['image']
      t.properties = metadata['properties']
      t.save!
    rescue StandardError => e
      puts '=========='
      puts e.message
      puts '=========='
    end
  end


  desc 'generate template skeleton'
  task generate: :environment do
    template_name = ARGV[1]
    raise "Please enter your template name eg: rake templates:generate <your-template-name>" unless template_name
    template_layout_path = 'app/views/layouts/templates/'
    template_path = "app/views/templates/#{template_name}/"
    template_pack_path = "app/javascript/packs/templates/#{template_name}/"
    template_asset_path = "app/javascript/templates/#{template_name}/"
    pages = ['about', 'contact', 'events', 'gallery', 'home', 'news', 'photos', 'privacy_policy', 'terms_condition']
    assets_dirs = ['images', "js", "styles"]
    FileUtils.touch("#{template_layout_path}#{template_name}.slim")
    FileUtils.mkdir_p(template_path)
    pages.each do |page|
      FileUtils.touch("#{template_path}#{page}.html.slim")
    end
    FileUtils.touch("#{template_path}fuitter.json")
    FileUtils.mkdir_p(template_pack_path)
    FileUtils.touch("#{template_pack_path}#{template_name}.js")
    FileUtils.mkdir_p(template_asset_path)
    assets_dirs.each do |asset_dir|
      FileUtils.mkdir_p("#{template_asset_path}#{asset_dir}")
    end

  end
end
