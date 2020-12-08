class UsersController < ApplicationController

  before_action :find_user, except: [:new, :create, :index]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end 

  def show
    @articles = @user.articles
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

  def edit
  end 

  def update 
    if @user.update(white_params_list)
      flash[:sucess] = "user updated successfully"
      redirect_to articles_path
    else 
      render 'edit'
    end 
  end 


  private

  def white_params_list
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end 
end 