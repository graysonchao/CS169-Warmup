class UsersController < ApplicationController

  def add
    name = request["user"]
    password = request["password"]

    if User.find_by_name(name) then
      @errCode = -2
    else
      u = User.create
      u.name = name
      u.password = password
      u.logins = 1
      @count = u.logins
      @errCode = 1
    end

  end

  def login
    name = request["user"]
    password = request["password"]
    u = User.find_by_name_and_password(name, password)

    if u then
      u.logins += 1
      u.save
      @count = u.logins
      @errCode = 1
    else
      @errCode = -1
    end

  end

end
