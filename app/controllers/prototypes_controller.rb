class PrototypesController < ApplicationController
    before_action :set_tweet, only: [:edit]
    before_action :authenticate_user!, except: [:index, :show, :create]
    before_action :move_to_index, except: [:index, :show, :create, :new, :update, :destroy]
  def index
    @prototypes = Prototype.all
    
  end

  def new
    @prototype = Prototype.new
  end

  def create
    # binding.pry
    @prototype = Prototype.new(prototype_params)
      if @prototype.save
      redirect_to root_path
      else
      render :new
      end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    # prototype.update(prototype_params)
      if @prototype.update(prototype_params)
      redirect_to prototype_path
      else
        render :edit
      end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_tweet
    @prototype = Prototype.find(params[:id])
  end
  def move_to_index
    #現在ログインしているユーザー  ==  プロトタイプの投稿者（ユーxsー）
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
  
end
