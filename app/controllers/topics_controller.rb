class TopicsController < ApplicationController
  COMMENTS_PER_PAGE = 10

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.where(id: params[:id]).first
    if @topic.nil?
      redirect_to forums_path
      flash[:error] = "Found no topic with id of #{params[:id]}"
      return
    end

    @number_of_pages = (@topic.comments.count / COMMENTS_PER_PAGE) + (@topic.comments.count % COMMENTS_PER_PAGE != 0 ? 1 : 0)
    @page_number = [params[:page_number].to_i, @number_of_pages].min
    @comments = @topic.comments.limit(COMMENTS_PER_PAGE).offset(COMMENTS_PER_PAGE * @page_number)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    # Don't allow the user to create a thread if he is not logged-in.
    forum = Forum::Forum.find(params[:forum_id])
    if not signed_in?
      flash[:error] = "Please login before trying to create a new topics in the forum."
      redirect_to forum_path(forum)
    return
    end

    # Don't allow the user to create thread if he hasn't the permissions to so.
    if not current_user.can_post_in_forum? forum
      flash[:error] = "You do not have access for creating new topics in this forum."
      redirect_to forum_path(forum)
    return
    end

    # Create a new Thread object.
    @topic = Topic.new
    @topic.author = current_user
    @topic.forum = forum
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new
    attrs = params[:topic]
    @topic.forum_id, @topic.author = attrs[:forum_id], current_user
    @topic.body, @topic.title = attrs[:body], attrs[:title]
    
    if attrs[:author_id] != current_user.id
      # TODO: Scold user for trying to cheat the system using
      # in-browser HTML editing tools.
      # Yes, this is the only reason there is such field in the form.
    end
    
    # Don't allow the user to create thread if he hasn't the permissions to do so.
    if not current_user.can_post_in_forum? @topic.forum
      flash[:error] = "You do not have access for creating new threads in this forum."
      redirect_to forum_path(forum)
    return
    end
    
    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end
end
