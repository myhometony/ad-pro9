class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday

    @twoday_ago_book =  @books.created_2day_ago
    @threeday_ago_book =  @books.created_3day_ago
    @fourday_ago_book =  @books.created_4day_ago
    @fiveday_ago_book =  @books.created_5day_ago
    @sixday_ago_book =  @books.created_6day_ago

    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def search#日付で検索投稿数
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""#①空欄なら日付を選択
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]#.countメソッド検索。ヒットした本を投稿した日付の投稿数を@search_bookで定義します。
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count#②
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  before_action :ensure_correct_user,{only:[:edit, :update]}

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
