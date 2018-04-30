class GroupsController < ApplicationController

  def show
    respond_to do |format|
      format.js {render 'groups/js/show'}
    end
  end

end
