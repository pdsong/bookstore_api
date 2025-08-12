class Api::V1::TokensController < ApplicationController
  # curl -X POST http://localhost:3000/api/v1/tokens \
  # -H "Content-Type: application/json" \
  # -d '{
  #   "user": {
  #     "email": "3@qq.com",
  #     "password": "3"
  #   }
  # }'

  #   JsonWebToken.decode("jwt_token_here")
  # => {"user_id" => 3, "exp" => 1746725130}

  def create
    @user=User.find_by_email(user_params[:email])
    if @user&.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token, email: @user.email }
    else
      render head :unauthorized
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
