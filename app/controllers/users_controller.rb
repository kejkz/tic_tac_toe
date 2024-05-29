class UsersController < ApplicationController
  def new
    redirect_to new_game_path if current_user.present?

    @new_user = User.new
  end

  def destroy
    redirect_to new_user_path if current_user.blank?

    if current_user.destroy
      flash[:success] = 'Session closed'

      redirect_to new_users_path, notice: 'Please sign in again'
    else
      flash[:errors] = current_user.errors.full_messages.as_sentence
    end
  end

  def create
    if current_user.present?
      redirect_to new_game_path, notice: 'User alredy signed in'
    end

    user = User.new
    user.assign_attributes(user_params)

    if user.save
      session[:user_id] = user.id
      flash[:success] = "Registered as #{user.name}"

      redirect_to new_game_path
    else
      flash[:error] = user.errors.full_messages.as_sentence

      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
