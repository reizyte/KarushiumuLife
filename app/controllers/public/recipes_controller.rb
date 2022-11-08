class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    @cooking_materials = @recipe.cooking_materials.build  #親モデル.子モデル.buildで子モデルのインスタンス作成
    @how_to_makes = @recipe.how_to_makes.build
  end


  def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true)
    #ジャンル検索
    @genres = Genre.all
    if params[:genre_id].present?
      #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @recipes = @genre.recipes
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @cooking_materials = @recipe.cooking_materials
    @how_to_makes = @recipe.how_to_makes
    #ジャンル検索
    @genres = Genre.all
    if params[:genre_id].present?
      #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @recipes = @genre.recipes
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    #@recipe.genre = Genre.find(1)
    @recipe.customer = current_customer
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:dish_name, :explanation, :cooking_time, :serving, :image, :genre_id,
                                  how_to_makes_attributes:[:id, :cooking_procedure, :_destroy],
                                  cooking_materials_attributes:[:id, :material_name, :quantity, :_destroy]
                                  )

  end
end
