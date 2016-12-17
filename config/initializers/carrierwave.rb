CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider:              ENV['FOG_PROVIDER'],
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['FOG_REGION'],
      host:                  ENV['FOG_HOST']
    }
    config.fog_directory  = ENV['FOG_DIRECTORY']
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  else
    config.asset_host = ActionController::Base.asset_host
  end

  config.storage = (Rails.env.production?) ? :fog : :file
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end