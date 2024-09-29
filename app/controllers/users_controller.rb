class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      render json: {
        status: 404,
        message: 'User not found'
      }
      return false
    end
    render json: @user
  end

  def login
    username =  params[:username]
    password = params[:password]

    if username == "" or password == ""
      render json: {
        status: 401,
        message: "Username or password can't be empty"
      }
      return false
    end

    #find username
    @user = User.find_by(username: username)

    if @user.nil?
      render json: {
        status: 401,
        message: "Username not found"
      }
      return false
    end


    if @user.authenticate(password) == false
      render json: {
        status: 401,
        message: "Invalid password"
      }
      return false
      end

    render json: {
      status: 200,
      message: "Login Successful",
      session_id:""
    }

  end

end
