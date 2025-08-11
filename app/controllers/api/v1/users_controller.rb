class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy ]

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # GET /api/v1/users/1
  # curl http://localhost:3000/api/v1/users/1

  # GET /api/v1/users/1
  # curl http://localhost:3000/api/v1/users/1
  def show
    render json: @user
  end

#   curl -X POST http://localhost:3000/api/v1/users -H "Content-Type: application/json" -d '{"user": {"email":"4@qq.com",  "password":"111"}}'
  def create
    @user= User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  # curl -X PUT http://localhost:3000/api/v1/users/1 -H "Content-Type: application/json" -d '{"user": {"email": "98982xxxx2222@qq.com"}}'
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end



  # curl -X DELETE http://localhost:3000/api/v1/users/1
  def destroy
    @user.destroy
    head 204
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
