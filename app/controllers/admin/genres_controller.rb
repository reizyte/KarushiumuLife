class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
     @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
        redirect_to admin_genres_path, notice: "ジャンルの作成に成功しました！"
    else
      @genres = Genre.all
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
       redirect_to admin_genres_path, notice: "ジャンルが更新されました！"
    else
       render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end


end
