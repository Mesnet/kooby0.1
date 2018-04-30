class CompaniesController < ApplicationController

  def show
    respond_to do |format|
      format.js {render 'companies/js/show'}
    end
  end

end
