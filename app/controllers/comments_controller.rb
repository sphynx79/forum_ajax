class CommentsController < ApplicationController
   before_action :set_comment, only: [:show, :edit, :update, :destroy]
   before_action :authenticate_user!,  except: [:create]



   # GET /comments/1/edit
   def edit
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
   end

   # POST /comments
   # POST /comments.json
   def create
      if user_signed_in? 
         @post = Post.find(params[:post_id])
         @comment = @post.comments.new(comment_params)
         @comment.user_id = current_user.id if current_user
         respond_to do |format|
            if @comment.save
               flash.now[:success] = 'Comment was successfully created.'
               format.html { redirect_to post_path(@post)}
               format.js{}
            else
               format.html { render :new }
               format.js {
                  flash.now[:error] = @comment.errors.full_messages.to_sentence
                  
               }
            end
         end
      else
         redirect_to  remote_sign_in_path and return
      end


   end

   # PATCH/PUT /comments/1
   # PATCH/PUT /comments/1.json
   def update
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])

      respond_to do |format|
         if @comment.update(comment_params)
            flash.now[:success] =  'Comment was successfully updated.'
            format.html { redirect_to post_path(@post) }
            format.js {}
         else
            flash.now[:notice] = "Comment could not be update" 
            format.html { render :edit }
            format.js {}
         end
      end
   end

   # DELETE /comments/1
   # DELETE /comments/1.json
   def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])

      @comment.destroy
      respond_to do |format|
         flash.now[:info] = 'Comment was successfully destroyed.'
         format.html { redirect_to post_path(@post) }
         format.js # JavaScript response
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_comment
      @comment = Comment.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def comment_params
      params.require(:comment).permit(:comment)
   end
end
