class HomeController < ApplicationController

  # GET / Make a single page app so all
  def index

  end

  # GET /about
  def about
    @your_name = 'alexis herrera'
    #
  end

  def data
    render "hi"
  end

end
