require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
#  if Rails.env.production? || Rails.env.staging? || Rails.env.review_app?
#   config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                 => ENV['AWS_REGION']
    }
    config.fog_authenticated_url_expiration = 60
    #config.cache_storage = :fog # set cache dir s3
    config.cache_dir = "#{Rails.root}/tmp/uploads" # for Heroku
    #config.fog_public = true
  #else
  #  config.storage = :file
  #end

case Rails.env
when 'production'
  Dotenv.load
  config.fog_directory = ENV['AWS_S3_BUCKET']
  config.asset_host = ENV['AWS_S3_URL']

#when 'development'
#  config.fog_directory = puts ENV['AWS_S3_BUCKET']
#  config.asset_host = puts ENV['AWS_S3_URL']
end

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end