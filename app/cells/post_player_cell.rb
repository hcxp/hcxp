class PostPlayerCell < Cell::ViewModel
  def show
    render
  end

  private

  def iframe_src
    album_id = model.settings.bandcamp_album_id
    size     = 'small'
    bgcol    = 'ffffff'
    linkcol  = 'e99708'

    "http://bandcamp.com/EmbeddedPlayer/album=#{album_id}/size=#{size}/bgcol=#{bgcol}/linkcol=#{linkcol}/transparent=true/"
  end
end
