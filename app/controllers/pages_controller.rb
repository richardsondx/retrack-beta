class PagesController < ApplicationController
  def home
    @title = "Home"
    @microposts = Micropost.all
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def main
    @title = "Welcome to Retrack"
  end
  
  def user_home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
end
  