class PrototypesController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
	def index
		@prototypes=Prototype.all

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
	

	private

	def prototype_params
		params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
	end
end
