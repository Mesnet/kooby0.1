class UserInfosController < ApplicationController
  before_action :set_user_info, only: [:update]

  def create
    @user_info = UserInfo.new(user_info_params)
    @first_name = @user_info.first_name.humanize.rstrip
    @second_name = @user_info.second_name.humanize.rstrip
    @pseudo = @user_info.pseudo.humanize.rstrip
    @initial = @first_name[0] + @second_name[0]
    @colors = ["#1B998B","#DB162F","#FFC61E","#00B760","#E0ED44","#003D6B","#AD8799","#007FCC", "#E5E059", "#BDD358", "#999799", "#E5625E","#083D77", "#DA4167", "#F78764", "#00F0B5", "#F61067", "#FBB13C", "#218380", "#FFD400", "#2589BD", "#187795","#38686A", "#BDD358", "#3E6990", "#381D2A", "#AABD8C"]
    @user_info.user = current_user
    respond_to do |format|
      if @user_info.save
        current_user.update(pseudo: @pseudo, initial: @initial, color: @colors.sample)
        format.js
      else
        format.html { render :new }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_infos/1
  # PATCH/PUT /user_infos/1.json
  def update
    respond_to do |format|
      if @user_info.update(user_info_params)
        format.html { redirect_to @user_info, notice: 'User info was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_info }
      else
        format.html { render :edit }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_infos/1
  # DELETE /user_infos/1.json
  def destroy
    @user_info.destroy
    respond_to do |format|
      format.html { redirect_to user_infos_url, notice: 'User info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_info
      @user_info = current_user.user_info
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_info_params
      params.require(:user_info).permit(:first_name, :second_name, :pseudo, :phone)
    end
end
