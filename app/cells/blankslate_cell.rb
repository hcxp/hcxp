class BlankslateCell < ApplicationCell
  def show
    render
  end

  private

  def title
    model[:title]
  end

  def description
    model[:description]
  end

end
