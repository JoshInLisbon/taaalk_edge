class CookiesController < ApplicationController
  def index_got_it_cookie
    cookies[:got_it] = { value: true, expires: Time.utc(2021, 11, 29, 23, 59, 59) }
    respond_to do |format|
      format.js { render 'got_it', layout: false }
    end
  end
end
