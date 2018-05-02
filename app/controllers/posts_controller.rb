class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  def open_new
    unless params[:projectid].blank?
      @project = Project.find(params[:projectid])
      # Params to secure the project access
      unless @project.participants.where(user_email_id: current_user.emails).any?
        redirect_to root_path, :flash => { :notice => "Insufficient rights !" }
      end
    end
    if @project == nil 
      @post = current_user.posts.unpublished.where(project_id: nil).last
      if @post == nil 
        @post = Post.create(user: current_user)
      end
    else
      @post = current_user.posts.unpublished.where(project_id: @project).last
      if @post == nil 
        @post = Post.create(user: current_user, project: @project)
      end
    end
    respond_to do |format|
      format.js {render 'posts/js/new'}
    end
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id, :project_id)
    end
end
