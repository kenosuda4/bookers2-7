class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]




  def new
    @book = Book.new(book_params)
  end
  
  def index
    @books = Book.all    
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
        @books = Book.all
        @user = current_user
        flash[:notice] = "error"
        render :'index'
    end
  end

  def show 
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @new_book = Book.new
    @user = @book.user
    @book_comments = @book.book_comments
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if  book.update(book_params)
        flash[:notice] = "Book was successfully created."
        redirect_to book_path
    else
      @book = Book.find(params[:id])
        flash[:notice] = "error"
        render :'edit'
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
    if current_user != user
      redirect_to books_path
    end
  end

end
