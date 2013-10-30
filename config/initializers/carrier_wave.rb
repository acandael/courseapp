CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => ENV['S3_KEY'],                        # required
      :aws_access_key_id      => ENV['S3_SECRET'],                        # required
      :aws_secret_access_key  => 'yyy',                        # required
    }
    config.fog_directory  = 'name_of_directory'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.production?
  end
end
