class BandsIndexService
  def initialize(col = Band.all, params = {})
    @col    = col
    @params = params
  end

  def call
    bands = @col
    bands = bands.search(@params[:query]) if @params[:query].present?
    bands = bands.where(id: @params[:id_in]) if @params[:id_in].present?

    bands
  end
end
