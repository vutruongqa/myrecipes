class ChefsController < ApplicationController

  before_action :set_chef, only: [:edit, :show, :update,:destroy]
  before_action :require_same_user, only: [:update, :edit, :destroy]
  before_action :require_admin, only: [:destroy]

  def new
    @chef = Chef.new
  end

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      #assign chef_id to cookie and session after creating account successfully
      session[:chef_id] = @chef.id
      cookies.signed[:chef_id] = @chef.id
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes application!"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def edit

  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page:5)
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Edit account successfully!"
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger] = "Chef and all associated recipes have been deleted!"
      redirect_to chefs_path
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end

  #prevent user to copies the url to edit other account
  def require_same_user
    if current_chef != @chef && !current_chef.admin?
      flash[:danger] = "You only can edit your own account!"
      redirect_to chefs_path
    end
  end

  def require_admin
    if logged_in? && !current_chef.admin?
      flash[:danger] = "Only admin users can perform that action"
    end
  end

end