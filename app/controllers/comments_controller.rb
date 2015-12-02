class CommentsController < ApplicationController
   before_action :set_comment, only: [:show, :edit, :update, :destroy]
   before_action :authenticate_user!



   # GET /comments/1/edit
   def edit
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
   end

   # POST /comments
   # POST /comments.json
   def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.new(comment_params)
      @comment.user_id = current_user.id if current_user

      respond_to do |format|
         if @comment.save
            format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
         else
            format.html { render :new }
         end
      end
   end

   # PATCH/PUT /comments/1
   # PATCH/PUT /comments/1.json
   def update
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])

      respond_to do |format|
         if @comment.update(comment_params)
            format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
         else
            format.html { render :edit }
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
         format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
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
