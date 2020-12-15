class UsersController < ApplicationController

  before_action :find_user, except: [:new, :create, :index]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only:[:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end 

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end 
  
  def create
    @user = User.new(white_params_list)
    if @user.save
        session[:user_id] = @user.id
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
  
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:success] = "user deleted successfully"
    redirect_to articles_path
  end 


  private

  def white_params_list
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end 

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your account"
      redirect_to @user
    end
  end 
end 