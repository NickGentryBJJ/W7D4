class UsersController < ApplicationController

    before_action :require_logged_in, only: [:edit, :update, :destroy, :index]

    def index
        @users = User.all 
        render :index 
    end


    def show
        @user = User.find_by(id: params[:id])
        render :show 
    end

    def new
        @user = User.new
        render :new 
    end

    def create
        @user = User.new(user_params)

        if @user.save 
            login!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end
    end

    # find_by will error loudly

    def edit 
        @user = User.find_by(id: params[:id])
        render :edit 
    end

    # flash.now before a render
    # flash before a redirect

    def update
        @user = User.find_by(id: params[:id])

        if @user.update( params[:user][:username] )
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :edit
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.destroy

        render :new
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
