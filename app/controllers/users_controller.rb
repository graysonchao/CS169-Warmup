class UsersController < ApplicationController
  #before_filter :ensure_json_request

  def add
    name = request["user"]
    password = request["password"]

    @count, @errCode = User.add(name, password)

    render :json => { :errCode => @errCode, :count => @count}
  end

  def login
    name = request["user"]
    password = request["password"]

    @count, @errCode = User.login(name, password)
    render :json => { :errCode => @errCode, :count => @count}
  end

end
