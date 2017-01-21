class BandsListCell < Cell::ViewModel
  def buttons(opts = {})
    @opts = opts
    render
  end

end
