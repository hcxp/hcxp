class CrawlBandcampLink < ActiveInteraction::Base
  IGNORED_PATHS = [
    %r{/track/},
    %r{/feed},
    %r{/gift_cards},
    %r{/contact},
    %r{/help},
  ].freeze

  string :link
  object :event

  attr_reader :uid, :name, :location, :photo_url, :tags, :photo_url, :albums,
              :band

  def execute
    @albums = []
    host = URI.parse(link).host
    @uid = host.split('.').first
    Rails.logger.info "Scrapping #{host} host"

    Spidr.host(host) do |spider|
      spider.every_url do |url|
        spider.skip_link! if IGNORED_PATHS.any? { |r| (url.path =~ r).present? }

        Rails.logger.debug "Scrap #{url}"
      end

      spider.every_page do |page|
        parse_page(page)
        parse_album(page)
      end
    end

    puts
    puts "Uid: #{uid}"
    puts "Name: #{name}"
    puts "Location: #{location}"
    puts "Photo url: #{photo_url}"
    # puts "Tags: #{tags.join(', ')}"
    puts 'Albums:'
    pp albums
    puts

    persist_band
    persist_context

    true
  end

  private

  def parse_page(page)
    @name ||= find_name(page)
    @location ||= find_location(page)
    @photo_url ||= find_photo_url(page)
  end

  def parse_album(page)
    res = page.search('div[itemtype="http://schema.org/MusicAlbum"] h2.trackTitle')

    if res.first.present?
      album_id = find_album_id(page)
      album_release_date = find_album_release_date(page)

      add_album(
        uid:  album_id,
        name: res.first.text.squish,
        released_at: album_release_date
      )
    end
  end

  def find_name(page)
    res = page.search('#band-name-location .title')
    res.first.present? ? res.first.text.squish : nil
  end

  def find_location(page)
    res = page.search('#band-name-location .location')
    res.first.present? ? res.first.text.squish : nil
  end

  def find_photo_url(page)
    res = page.search('.band-photo')
    res.first.present? ? res.first.attr('src').squish : nil
  end

  def find_album_id(page)
    url = page.search('//meta[@property="og:video"]')
              .first
              .attributes['content']
              .value

    return url.match(%r{/album=(\d+)/})[1]
  end

  def find_album_release_date(page)
    res = page.search('//meta[@itemprop="datePublished"]')
              .first
              .attributes['content']
              .value

    Date.parse(res)
  end

  def add_album(opts = {})
    present = albums.any? { |a| a[:uid] == opts[:uid] }

    if present
      Rails.logger.debug "Album #{opts[:name]} already registered, skip"
    else
      Rails.logger.debug "Registering album #{opts[:name]}"
      @albums << opts
    end
  end

  def persist_band
    @band = Band.where(uid: uid).first_or_initialize

    band.uid = uid
    band.name = name
    band.location = location
    band.photo_url = photo_url

    band.save!
  end

  def persist_context
    event.bands << band unless event.bands.include? band
  end
end
