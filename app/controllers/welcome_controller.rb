# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @tutorials = if current_user
                   if params[:tag]
                     Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                   else
                     Tutorial.all.paginate(page: params[:page], per_page: 5)
                                end
                 else
                   if params[:tag]
                     Tutorial.no_classroom.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                   else
                     Tutorial.no_classroom.all.paginate(page: params[:page], per_page: 5)
                                end
                 end
  end
end
