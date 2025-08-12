module Authenticable
  def current_user
    return @current_user if @current_user
    header=request.headers["Authorization"]
    return nil  if header.nil?
    decoded=JsonWebToken.decode(header)
    # 但 find_by 找不到时会返回 nil，不会抛异常，只有 find 会抛异常。
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end
end
