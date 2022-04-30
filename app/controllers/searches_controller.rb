class SearchesController < ApplicationController
  #before_action :search_searches, only: [:index, :search]
  #def index
    #@s = Book.ransack(params[:q])
    #@books = @s.result(distinct: true)
    #@searches = Search.includes(:user).order('created_at DESC').limit(4)
    #@ranks = Search.find(Like.group(:seach_id).order('count(search_id) DESC').limit(4).pluck(:seach_id))
  #end




  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    if @range == '1'
      @users = User.search(search,word)
    else
      @books = Book.search(search,word)
    end
    #@results = @s.result(distinct: true)
  end
  #検索結果取得.result

  #private

  #def search_searches
    #@s = Search.ransack(params[:q])
  #end
  #searchesテーブルから情報を探している。＠は検索オブジェクト
end
