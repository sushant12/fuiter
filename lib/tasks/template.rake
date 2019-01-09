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
end
