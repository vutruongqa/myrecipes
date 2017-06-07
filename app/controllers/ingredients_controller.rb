class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]
  before_action :require_admin, except: [:show, :index]

  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:id], per_page: 5)
  end

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Create ingredient successfully"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Update ingredient successfully"
      redirect_to ingredient_path(@ingredient)
    else
      render 'edit'
    end
  end

  def destroy

  end

  private
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_chef.admin)
      flash[:danger] = "Only admin can perform this operation!"
      redirect_to ingredients_path
    end
  end

end