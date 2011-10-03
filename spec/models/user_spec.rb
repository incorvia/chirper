require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
              :name => "Kevin Incorvia", 
              :email => "incorvia@gmail.com",
              :password => "foobar", 
              :passsword_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end


  describe "name validations" do        # --------  Name  --------
    
    it "should require a name" do
      no_name_user = User.new(@attr.merge(:name => ""))
      no_name_user.should_not be_valid
    end
  
    it "should have length less than 51 characters" do
      long_name = "a" * 51
      long_user = User.new(@attr.merge(:name => long_name))
      long_user.should_not be_valid
    end
  end

  
  describe "email validations" do       # --------  Email  --------
    
    it "should require an email" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end 
  
    it "should accept valid email addresses" do
     addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |addresses|
        valid_email_user = User.new(@attr.merge(:email => addresses))
        valid_email_user.should be_valid
      end
    end
  
    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end
  
    it "should reject duplicate email addresses" do
      # Put a user with given email address into the database.
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
     user_with_duplicate_email.should_not be_valid
    end
  
    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
  end

  describe "password validations" do      # --------  Password  --------
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short messages" do
      short = "a" * 5
      User.new(@attr.merge(:password => short, :password_confirmation => short)).
        should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      User.new(@attr.merge(:password => long, :password_confirmation => long)).
        should_not be_valid
    end
  end
  
  describe "password encrpytion" do       # --------  Encryption  --------
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end  
  
    describe "has_password? method" do       # --------  Has Password  --------
    
      it "should respond true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
    
      it "should return false if passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
  
    describe "authenticate user" do          # --------  Authentication  --------
  
      it "should return nil on email / pasword mis-match" do
        wrong_password_user = User.authenticate(@attr[:email], "wrong")
        wrong_password_user.should be_nil
      end
    
      it "should return nil for an email address with no user" do
        nonexistant_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistant_user.should be_nil
      end
      
      it "should return the user on email / password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user == @user
      end
    end
  end

  describe "admin attribute" do         # --------  Admin Attribute  --------
    
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe "micropost associations" do

    before(:each) do
      @user = User.create(@attr)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end
  end
  
end
