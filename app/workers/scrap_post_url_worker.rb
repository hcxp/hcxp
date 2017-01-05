class ScrapPostUrlWorker
  include Sidekiq::Worker

  def perform(post_id)
    @post = Post.find(post_id)

    # Initialize page object with meta data
    page = MetaInspector.new(@post.url)

    # Save bandcamp metadata
    set_bandcamp_album_id(page) if bandcamp?

    # Save generic post data
    @post.update_attributes(
      title:                page.best_title,
      remote_thumbnail_url: page.images.best,
      crawled_at:           Time.zone.now
    )
  end

  private # --------------------------------------------------------------------

  def set_bandcamp_album_id(page)
    logger.debug 'Trying to save bandcamp_album_id if possible'
    og_video = page.meta_tag['property']['og:video'] rescue nil

    return false unless og_video

    logger.debug 'og:video found for bandcamp link. Save it.'
    album_id = og_video[/album=\d+/][/\d+/]
    @post.settings.bandcamp_album_id = album_id
  end

  def bandcamp?
    URI(@post.url).host[/bandcamp.com\z/] != nil
  end
end