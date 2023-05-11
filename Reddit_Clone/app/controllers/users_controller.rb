class UsersController < ApplicationController


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

    def edit 
        @user = User.find_by(id: params[:id])
        if @user
            render :edit 
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        render :new
    end
end
