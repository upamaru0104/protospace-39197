class UsersController < ApplicationController
  def show
    @name = current_user.name
    @prototypes = current_user.prototypes
    @user = User.find(params[:id])
  end

  private

	def user_params
		params.require(:user).permit(:name, :profile, :occupation, :position).merge(user_id: current_user.id)
	end
end
