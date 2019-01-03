namespace :templates do
  desc "add local template info into db"
  task sync: :environment do
    base_dir = Rails.root.join("app","views","templates")
    templates = Dir.children(base_dir)
    templates.each do |template|
      next unless File.directory? template
      config = "#{base_dir}/#{template}/fuitter.json"
      metadata = JSON.parse(File.read(config))
      Template.find_or_create_by!(name: metadata["name"]) do |t|
        t.name = metadata["name"]
        t.image = metadata["image"]
      end
    rescue => e
      puts "=========="
      puts e.message
      puts "=========="
    end
  end
end

