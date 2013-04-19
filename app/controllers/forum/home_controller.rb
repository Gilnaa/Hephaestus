class Forum::HomeController < ApplicationController
  def index
    @categories = Forum::Category.all
  end

  def view
    @forum = Forum::Forum.find params[:id]
  end
end
