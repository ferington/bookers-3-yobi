class BooksController < ApplicationController
  

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def edit
    is_matching_login_book
    @book = Book.find(params[:id])
  end


  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @books = Book.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_book
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
  

end
