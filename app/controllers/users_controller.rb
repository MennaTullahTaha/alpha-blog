class UsersController < ApplicationController
  def new
    @user = User.new
  end 
  
  def create
    @user = User.new(white_params_list)
    if @user.save
        flash[:success] = "#{@user.username} created successfully"
        redirect_to articles_path
    else
        render 'new'
    end 
  end 


  private

  def white_params_list
    params.require(:user).permit(:username, :email, :password)
  end
end 