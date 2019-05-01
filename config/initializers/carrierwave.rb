CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:                 'AWS',
      aws_secret_access_key:     ENV['AWS_SECRET_ACCESS_KEY'],
      aws_access_key_id:         ENV['AWS_ACCESS_KEY_ID'],
      region:                    ENV['AWS_S3_REGION'],
      host:                      ENV['AWS_S3_HOST_NAME']
  }
  config.fog_directory  = ENV['AWS_S3_BUCKET']
end