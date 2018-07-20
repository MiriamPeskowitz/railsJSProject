class UsersController < ApplicationController

  def index
    @users = User.all
  end

	def new
		@user = User.new
	end 

#signup
	def create
	  @user = User.new(user_params)
	  if @user.save
		  session[:user_id] = @user.id 
      #can be replaced with login_in @user (from the Sessions Helper) 
		  redirect_to soupkitchens_path #go to index, add My profile tab to layout page. comes up with the current_user menu
	  else 
		  render :new
  	end
	end

  def show
    if logged_in?
      @user = User.find(params[:id])
      @soupkitchens = Soupkitchen.all
    else
      redirect_to root_path
    end 
  end 

  def edit 
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@suser), notice: "Changes to #{@user.name} were successful."
    else 
      render :edit
    end 
  end 

  def destroy
    @user.destroy
    redirect_to @users_path
  end 
  private
	def user_params
      params.require(:user).permit( :first_name, :last_name, :email, :mobile_number, :password, :password_confirmation)
       
    end
end
