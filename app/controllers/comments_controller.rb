class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show destroy ] 
  before_action :redirect_request, only: %i[edit update destroy]
  
  # GET /comments/1 or /comments/1.json
  def show
  end
  
  # GET /comments/new
  def new
    @comment = Comment.new
  end
  
  # GET /comments/1/edit
  def edit
  end
  
  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    if user_signed_in?
      @comment.user = current_user
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_url(@comment), notice: "Tú comentario fue creado con éxito." }
      else
          format.html { redirect_to comments_url(@comment), notice: "No se pudo crear tú comentario" }
        end
      end
    end
  
    # DELETE /comments/1 or /comments/1.json
    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_url(@comment), notice: "Tú comentario fue eliminado con éxito" }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:content, :user_id, :post_id )
      end
      def redirect_request
        if current_user.id != @comment.user_id
          redirect_to comments_url(@comment), notice: "No puedes hacer eso pillin"
        end
      end
end
