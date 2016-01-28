class HomeController < ApplicationController

  def index
    add_breadcrumb "Home", home_path
  end
end
