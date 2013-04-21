#-------------------------------------------------------------------------------
# Copyright (c) 2013 Gilad Naaman.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0
# which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/gpl.html
#
# Contributors:
#     Gilad Naaman - initial API and implementation
#-------------------------------------------------------------------------------
class Forum::ThreadsController < ApplicationController
  COMMENTS_PER_PAGE = 20
  def show
    @thread = Forum::Thread.find(params[:thread_id])
    @number_of_pages = @thread.comments.count / COMMENTS_PER_PAGE
    @page_number = [params[:page_number].to_i, @number_of_pages].min
    @comments = @thread.comments.limit(COMMENTS_PER_PAGE).offset(COMMENTS_PER_PAGE * @page_number)
  end

  def new
    # Don't allow the user to create a thread if he is not logged-in.
    forum = Forum::Forum.find(params[:forum_id])
    if not signed_in?
      flash[:error] = "Please login before trying to create a new thread in the forum."
      redirect_to forum_path(forum)
    return
    end

    # Don't allow the user to create thread if he hasn't the permissions to so.
    if not current_user.can_post_in_forum? forum
      flash[:error] = "You do not have access for creating new threads in this forum."
      redirect_to forum_path(forum)
    return
    end

    # Create a new Thread object.
    @thread = Forum::Thread.new
    @thread.author = current_user
    @thread.forum = forum
    

  end

  def create
    flash[:error] = params[:forum_thread]
    @thread = Forum::Thread.new
    attributes =  params[:forum_thread]
    @thread.author = current_user
    @thread.forum_id = attributes[:forum_id]
    @thread.body = attributes[:body]
    @thread.title = attributes[:title]
    
    # Don't allow the user to create thread if he hasn't the permissions to so.
    if not current_user.can_post_in_forum? @thread.forum
      flash[:error] = "You do not have access for creating new threads in this forum."
      redirect_to forum_path(forum)
      return
    end
    
    if @thread.save
      flash[:info] = "Thread posted successfuly!"
      redirect_to @thread
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def delete
    @thread = Thread.find(params[:thread_id])
    if not current_user.is_moderator
      redirect_to @thread
    end
    @thread.destroy
  end
  
  def comment
    flash[:info] = params[:comment].to_s
    redirect_to root_path
  end
end
