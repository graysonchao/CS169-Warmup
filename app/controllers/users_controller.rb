class UsersController < ApplicationController
  #before_filter :ensure_json_request

  def add
    name = request["user"]
    password = request["password"]

    # Not strictly necessary to assign to ivars like this,
    # but it makes it easier to screw around with JSON response crafting
    @count, @errCode = User.add(name, password)

    if @count > 0 then
      render :json => { :errCode => @errCode, :count => @count}
    else
      render :json => { :errCode => @errCode }
    end
  end

  def login
    name = request["user"]
    password = request["password"]

    @count, @errCode = User.login(name, password)
    if @count > 0 then
      render :json => { :errCode => @errCode, :count => @count}
    else
      render :json => { :errCode => @errCode }
    end
  end

end
