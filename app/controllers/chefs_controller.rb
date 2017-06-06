class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes application!"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page:5)
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Edit account successfully!"
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def destroy
    @chef = Chef.find(params[:id])
    @chef.destroy
    redirect_to chefs_path
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

end