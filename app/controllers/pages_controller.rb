class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def terms
    @pop = "pop"
  end

  def privacy
    @pop = "pop"
  end

end
