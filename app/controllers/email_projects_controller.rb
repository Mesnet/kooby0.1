class EmailProjectsController < ApplicationController
  before_action :security_params

  def create
    @email_project = EmailProject.new(email_project_params)

    respond_to do |format|
    #Perform it into a background job
      # if first letter @ (it's a user)
        # search user into current_user contact
      # elsif first letter # (it's a group of users)
        # search group of users into current_user contact
      # else (is an email)
        # create
      # end

      if @email_project.save
        @email = UserEmail.where(email: @email_project.email).first_or_create
        @user = UserProject.create(project: @project, user_email_id: @email.id, role: @email_project.role)
        format.js {render 'projects/js/invit'}
      else
        redirect_back
      end
    end
  end

  private

  def security_params
    @project = Project.find(params[:email_project][:project_id])
    @my_user = @project.participants.where(user_email_id: current_user.emails).first
    if @my_user.role == 1
      @admin = true
    end
    unless @admin
      redirect_back
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def email_project_params
    params.require(:email_project).permit(:email, :role, :project_id)
  end

end
