CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:                 'AWS',
      aws_secret_access_key:     Fuitter.credentials[:aws_secret_access_key],
      aws_access_key_id:         Fuitter.credentials[:aws_access_key_id],
      region:                    Fuitter.credentials[:aws_s3_region,
      host:                      Fuitter.credentials[:aws_s3_host_name]
  }
  config.fog_directory  = Fuitter.credentials[:aws_s3_bucket]
end