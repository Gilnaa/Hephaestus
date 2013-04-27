class CommentsController < ApplicationController
  def show
    return unless comment_exists? params[:id]
    comment = Comment.find params[:id]
    redirect_to topic_path(comment.topic, comment_id: comment.id)
  end

  def new
    return unless topic_exists? params[:topic_id]
    @topic = Topic.find :first, params[:topic_id]
    
    unless signed_in?
      flash[:error] = I18n.t 'general.sign_in_to_create_content'
      redirect_to @topic
    end
    unless current_user.can_comment_in_topic? @topic
      flash[:error] = I18n.t 'forum.no_comment_permissions'
      redirect_to @topic
    end
    @comment = Comment.new
    @comment.author = current_user
    @comment.topic = @topic
    @comment.title = "Re: " << @topic.title
  end

  def create
    attrs = params[:comment]
    return unless topic_exists? attrs[:topic_id]
    
    @comment = Comment.new
    @comment.topic_id, @comment.author = attrs[:topic_id], current_user
    @comment.body, @comment.title = attrs[:body], attrs[:title]

    if attrs[:author_id] != current_user.id
      # TODO: Scold user for trying to cheat the system using
      # in-browser HTML editing tools.
      # Yes, this is the only reason there is such field in the form.
    end

    # Don't allow the user to create thread if he hasn't the permissions to do
    # so.
    unless current_user.can_comment_in_topic? @comment.topic
      flash[:error] = I18n.t 'forum.no_comment_create_permission'
      redirect_to forum_path(forum)
    return
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: I18n.t('forum.comment_created') }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    return unless comment_exists? params[:id]
    
    @comment = Comment.find(params[:id])
    unless current_user.can_moderate_forum? @comment.forum
      if not signed_in? or (current_user != @comment.author)
        flash[:error] = I18n.t 'forum.comment_created'
        redirect_to @comment
      return
      end
    end
  end

  def update
    return unless comment_exists? params[:id]
    
    @comment = Comment.find params[:id]
    attrs = params[:comment].dup
    attrs.delete :author_id
    attrs.delete :topic_id

    respond_to do |format|
      if @comment.update_attributes attrs
        format.html { redirect_to @comment, notice: I18n.t('forum.comment_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    return unless comment_exists? params[:id]
    @comment = Comment.find(params[:id])
    topic = @comment.topic
    unless signed_in? and current_user.can_moderate_forum? @comment.forum
      flash[:error] = I18n.t 'forum.no_comment_delete_permission'
      redirect_to @comment
    return
    end

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic }
      format.json { head :no_content }
    end
  end
end
