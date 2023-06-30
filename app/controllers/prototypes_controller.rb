class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
	def index
		@prototypes=Prototype.includes(:user)
	end

	def new
		@prototype=Prototype.new
	end

	def create
		@prototype = Prototype.create(prototype_params)
	
		if @prototype.save
			redirect_to action: :index
		else
			render :new
		end
	end
	
	def show
		@prototype = Prototype.find(params[:id])
		@comments = @prototype.comments.includes(:user)
		@comment = Comment.new
		if @comment.save
			redirect_to prototype_path(@comment.prototype)
		else
			render :show
		end
	end

	def edit
		@prototype = Prototype.find(params[:id])
		unless @prototype.user == current_user
			redirect_to action: :index
		end
	end

	def update
		@prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)

		if @prototype.save
			redirect_to action: :show
		else
			render :edit
		end
	end

	def destroy
		prototype = Prototype.find(params[:id])
    prototype.destroy
		redirect_to action: :index
	end

	private

	def prototype_params
		params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
	end
end
