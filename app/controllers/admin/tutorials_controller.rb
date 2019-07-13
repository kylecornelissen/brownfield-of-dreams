# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    params_tutorial = params[:tutorial]
    tutorial = Tutorial.new(title: params_tutorial[:title],
                            description: params_tutorial[:description],
                            thumbnail: params_tutorial[:thumbnail])
    if tutorial.save
      flash[:success] = 'Successfully created tutorial.'
      redirect_to tutorial_path(tutorial)
    else
      flash[:error] = 'There was a problem creating the tutorial.'
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
