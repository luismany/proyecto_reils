
class Authentication::UsersController < ApplicationController
  # Permite el acceso a las acciones new y create sin necesidad de que el usuario haya iniciado sesion.
  skip_before_action :paginas_protegidas

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
     if @user.save
      # session[:user_id] = @user.id guarda el id del usuario en la sesion para mantener la sesion iniciada.
       session[:user_id] = @user.id
       redirect_to productos_path, notice: 'Usuario Creado Correctamente.'
     else
       render :new, status: :unprocessable_entity
     end
  end

  private

  def user_params
     params.require(:user).permit(:email, :username, :password)
  end
end