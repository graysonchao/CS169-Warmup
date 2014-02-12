class UsersController < ApplicationController
  before_filter :ensure_json_request

  def add
    name = request["user"]
    password = request["password"]

    @count, @errCode = User.add(name, password)
  end

  def login
    name = request["user"]
    password = request["password"]

    @count, @errCode = User.login(name, password)
  end

end
