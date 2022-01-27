require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    # passing test
    it "should be valid if all required information is present" do
      @user = User.new
      @user.first_name = "first_name"
      @user.last_name = "last_name"
      @user.email = "email@email.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      @user.save!
      expect(@user.first_name).to be_present
      expect(@user.last_name).to be_present
      expect(@user.email).to be_present
      expect(@user.password).to be_present
      expect(@user.password_confirmation).to be_present
    end

    # name tests
    it "should be invalid and throw error if first_name is not present" do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "last_name"
      @user.email = "email@email.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it "should be invalid and throw error if last_name is not present" do
      @user = User.new
      @user.first_name = "first_name"
      @user.last_name = nil
      @user.email = "email@email.com"
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    # email tests 
    it "should be invalid and throw error if email is not present" do
      @user = User.new
      @user.first_name = "first_name"
      @user.last_name = "last_name"
      @user.email = nil
      @user.password = "12345678"
      @user.password_confirmation = "12345678"
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it "should be invalid if email exists" do
      @user1 = User.new
      @user1.first_name = "first_name"
      @user1.last_name = "last_name"
      @user1.email = "email@email.com"
      @user1.password = "12345678"
      @user1.password_confirmation = "12345678"
      @user1.save!

      @user2 = User.new
      @user2.first_name = "first_name"
      @user2.last_name = "last_name"
      @user2.email = "Email@email.com"
      @user2.password = "12345678"
      @user2.password_confirmation = "12345678"
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
    end

    # password tests
    it "should be invalid if passwords dont match" do
      @user = User.new
      @user.first_name = "first_name"
      @user.last_name = "last_name"
      @user.email = "email@email.com"
      @user.password = "password"
      @user.password_confirmation = "not password"
      expect(@user).to be_invalid
    end

    it "should be invalid if password and password confirmation are not provide" do
      @user = User.new
      @user.first_name = "first_name"
      @user.last_name = "last_name"
      @user.email = "email@email.com"
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to be_invalid
    end

    it "should be invalid if password is too short" do
      @user = User.new
      @user.first_name = "first_name"
      @user.last_name = "last_name"
      @user.email = "email@email.com"
      @user.password = "1234567"
      @user.password_confirmation = "1234567"
      expect(@user).to be_invalid
    end
  end
end
