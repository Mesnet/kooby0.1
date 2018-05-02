class ProjectsController < ApplicationController
  before_action :set_project, except: [:create, :open_new]
  before_action :set_my_user_project, except: [:create, :open_new]
  before_action :my_user_admin, only: [:open_params, :update, :expel, :upd_role, :destroy]
  before_action :administrator, only: [:update, :expel, :upd_role, :destroy]
  before_action :set_user, only: [:quit, :expel, :upd_role]
  # Admin, only: [:expel, :upd_role, :update, :destroy]

  def show 
  end

  def taskboard 
  end

  def calendar 
  end

  def cloud 
  end

  def mute
    @my_user.update(priority: 3)
    respond_to do |format|
      format.js {render 'projects/js/fav'}
    end
  end

  def unmute
    @my_user.update(priority: 2)
    respond_to do |format|
      format.js {render 'projects/js/fav'}
    end
  end

  def fav 
    @my_user.update(priority: 1)
    respond_to do |format|
      format.js {render 'projects/js/fav'}
    end
  end 

  def unfav
    @my_user.update(priority: 2)
    respond_to do |format|
      format.js {render 'projects/js/fav'}
    end
  end

  def quit
    # Prevent no admin error
    if @user.role == 1 && @project.admins.count == 1
      respond_to do |format|
        format.js {render 'projects/js/upd_role_error'}
      end
    else

      # Prevent code modification 
      if @user.email.user == current_user
        @user.destroy
        respond_to do |format|
          format.js {render 'projects/js/quit'}
        end
      else
        redirect_back
      end

    end
  end

  def expel
    @user.destroy
    respond_to do |format|
      format.js {render 'projects/js/expel'}
    end
  end

  def upd_role
    # Prevent no admin error
    if @user.role == 1 && @user.participate == true && @project.admins.count == 1
      respond_to do |format|
        format.js {render 'projects/js/upd_role_error'}
      end
    else

      # Prenvent code modification
      if params[:role] == nil
       @role = 2
      else 
        @role = params[:role]
      end

      @user.update(role: @role)
      respond_to do |format|
        # If it's the current_user close the modal
        if @user.email.user == current_user
          format.js {render 'projects/js/update'}
        else 
          if @user.participate == true
            @invited = true
          else 
            @invited = false
          end
          format.js {render 'projects/js/upd_role'}
        end
      end

    end
    
  end

  def open_params
    @participants = @project.participants.includes(:user_email)
    @inviteds = @project.inviteds.includes(:user_email)
    respond_to do |format|
      format.js {render 'projects/js/params'}
    end
  end

  def open_new
    respond_to do |format|
      format.js {render 'projects/js/new'}
    end
  end

  def show
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        @user = UserProject.create(user_email_id: current_user.emails.first.id, project_id: @project.id, role: 1, participate: true)
        format.js {render 'projects/js/create'}
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.js {render 'projects/js/update'}
      else
        redirect_back
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.update(removed: true)
    @project.participants.destroy_all
    respond_to do |format|
      format.js {render 'projects/js/destroy'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_my_user_project
      @my_user = @project.participants.where(user_email_id: current_user.emails).first
      if @my_user.nil?
        redirect_to root_path, :flash => { :notice => "Insufficient rights !" }
      end
    end

    def my_user_admin
      if @my_user.role == 1
        @admin = true
      end
    end

    def administrator
      unless @admin
        redirect_back
      end
    end

    def set_user
      @user = UserProject.find(params[:userid])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :cat)
    end
end
