class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def index
    @chefs = Chef.all
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

  def show

  end

  def update

  end

  def destroy

  end

  private

  def chef_params
      params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

end