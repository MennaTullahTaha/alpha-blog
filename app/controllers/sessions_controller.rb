class SessionsController < ApplicationController
    def new 
    end 

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to @user
        else 
            flash.now[:notice] = "There was an error with your login"
            render 'new'
        end 
    end 

    def destroy
        session[:user_id] = nil;
        flash[:notice] = "logged out"
        redirect_to root_path
    end 
end 