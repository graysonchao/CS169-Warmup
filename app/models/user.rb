class User < ActiveRecord::Base

  # I don't really know what the idiomatic way to do this is.
  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2 
  ERR_BAD_USERNAME = -3 
  ERR_BAD_PASSWORD = -4

  MAX_PASSWORD_LENGTH = 128
  MAX_USERNAME_LENGTH = 128

  # Returns a tuple of [USER login ct, error code].
  def self.login(user, pass)

    if !pass or pass.length > 128 then
      return [0, ERR_BAD_PASSWORD]
    end

    u = User.find_by_name_and_password(user, pass)
    if u then
      u.logins += 1
      u.save
      return [u.logins, SUCCESS]
    else
      [0, ERR_BAD_CREDENTIALS]
    end
  end

  # Returns a tuple of [USER login ct, error code].
  def self.add(user, pass)

    if !user or user.length > 128 then
      return [0, ERR_BAD_USERNAME]
    elsif !pass or pass.length > 128 then
      return [0, ERR_BAD_PASSWORD]
    elsif User.find_by_name(user) then
      return [0, ERR_USER_EXISTS]
    end

    u = User.new
    u.name = user
    u.password = pass
    u.logins = 1
    u.save

    [u.logins, SUCCESS]
  end

end
