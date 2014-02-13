require 'spec_helper'

SUCCESS = 1
ERR_BAD_CREDENTIALS = -1
ERR_USER_EXISTS = -2
ERR_BAD_USERNAME = -3
ERR_BAD_PASSWORD = -4

describe User do
  before :each do
    @result = User.add("bob", "password")
    @bob = User.find_by_name("bob")
  end

  describe "#add" do
    it "takes a username and password and returns a User" do
      @bob.should be_an_instance_of User
      @result[1].should eql SUCCESS
    end

    it "can't add a user with no name" do
      badadd = User.add("", "password")
      badadd[1].should eql ERR_BAD_USERNAME
    end

    it "can't add a user with name >128char" do
      badadd = User.add("a"*129, "a"*127)
      badadd[1].should eql ERR_BAD_USERNAME
    end

    it "can't have a password >128 char" do
      badadd = User.add("bro", "a"*129)
      badadd[1].should eql ERR_BAD_PASSWORD
    end

    it "can add a user with no password" do
      goodadd = User.add("hello", "")
      goodadd[1].should eql SUCCESS
    end
  end

  describe "#login" do

    it "can log in a user who exists" do
      User.login("bob", "password")[1].should eql SUCCESS
    end

    it "increments login count on login" do
      ct = User.login("bob", "password")[0]
      User.login("bob", "password")[0].should eql (ct + 1)
    end

    it "can't log in a user with the wrong password" do
      User.login("bob", "wrong")[1].should eql ERR_BAD_CREDENTIALS
    end

    it "can't log in a nonexistent user" do
      User.login("rando", "")[1].should eql ERR_BAD_CREDENTIALS
    end
  end
end
