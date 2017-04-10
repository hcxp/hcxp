class ScrapBandcampPhotoWorker
  include Sidekiq::Worker

  def perform(band_id, url)
    @band = Band.find(band_id)
    @url  = url

    logger.info "Trying to scrap band-photo for #{@band.name} using url #{url}"
    page = Nokogiri::HTML(open(url)).css('.band-photo')

    if page.any?
      band_photo = page.first.attributes['src'].value
      logger.info "Found band-photo: #{band_photo}"
      @band.update_attribute(:remote_photo_url, band_photo)
    else
      logger.info "No band-photo found for given URL"
    end
  end

end