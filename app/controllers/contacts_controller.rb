class ContactsController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  def show_sn
    respond_to do |format|
      format.js {render 'contacts/js/show_sn'}
    end
  end

  def show
    respond_to do |format|
      format.js {render 'contacts/js/show'}
    end
  end

end
