require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    # passing test
    it "should be valid if all required information is present" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "12345678", password_confirmation: "12345678")
      @user.save!
      expect(@user.first_name).to be_present
      expect(@user.last_name).to be_present
      expect(@user.email).to be_present
      expect(@user.password).to be_present
      expect(@user.password_confirmation).to be_present
    end

    # name tests
    it "should be invalid and throw error if first_name is not present" do
      @user = User.new(first_name: nil, last_name: "last_name", email: "email@email.com", password: "12345678", password_confirmation: "12345678")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it "should be invalid and throw error if last_name is not present" do
      @user = User.new(first_name: "first_name", last_name: nil, email: "email@email.com", password: "12345678", password_confirmation: "12345678")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

    # email tests 
    it "should be invalid and throw error if email is not present" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: nil, password: "12345678", password_confirmation: "12345678")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it "should be invalid if email exists" do
      @user1 = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "12345678", password_confirmation: "12345678")
      @user1.save!

      @user2 = User.new(first_name: "first_name", last_name: "last_name", email: "Email@email.com", password: "12345678", password_confirmation: "12345678")
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
    end

    # password tests
    it "should be invalid if passwords dont match" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "password", password_confirmation: "not password")
      expect(@user).to be_invalid
    end

    it "should be invalid if password and password confirmation are not provide" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "nil", password_confirmation: "nil")
      expect(@user).to be_invalid
    end

    it "should be invalid if password is too short" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "email@email.com", password: "1234567", password_confirmation: "1234567")
      expect(@user).to be_invalid
    end
  end
end
