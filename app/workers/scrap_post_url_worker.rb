class ScrapPostUrlWorker
  include Sidekiq::Worker

  def perform(post_id)
    @post = Post.find(post_id)

    page = MetaInspector.new(@post.url)

    @post.update_attributes(
      title:                page.best_title,
      remote_thumbnail_url: page.images.best,
      crawled_at:           Time.zone.now
    )
  end
end