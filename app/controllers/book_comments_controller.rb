class BookCommentsController < ApplicationController
    def create
       @book = Book.find(params[:book_id])
       @comment = current_user.book_comments.new(book_comment_params)
       @comment.book_id = @book.id
       @comment.user_id = current_user.id
       if @comment.save
        # 非同期様にリダイレクト先を削除
        #   redirect_to book_path(book)
       else
        flash[:error] = "error"
        redirect_to request.referrer 
       end
    end

    def destroy
        @book_comment = BookComment.find(params[:book_id])
        @book = @book_comment.book
        @book_comment.destroy
        #book = Book.find(params[:book_id]) #↓のbookをここで定義
        #redirect_to book_path(book)        #Nameエラー　上で定義＋下の方法もある
        # redirect_to request.referrer 
    end
    
    private
    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end

    def set_book
        @book_comment = BookComment.find(params[:id])
    end

    
end
