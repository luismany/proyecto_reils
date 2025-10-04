
class Authentication::SessionsController < ApplicationController
  # Permite el acceso a las acciones new y create sin necesidad de que el usuario haya iniciado sesion.
  skip_before_action :paginas_protegidas

  def new
    
  end

  def create
    # - Busca un usuario en la tabla users donde el email o el username coincidan con el valor que viene en params[:login].
    # - Si encuentra un usuario, lo asigna a la variable @user.
     @user= User.find_by("email = :login OR username = :login", {login: params[:login]})

     # @user&.authenticate(params[:password]) es una forma segura de llamar al metodo authenticate en caso de que @user sea nil.
     # authenticate es un metodo proporcionado por has_secure_password que verifica si el password coincide con el password digest almacenado en la base de datos.
     if @user&.authenticate(params[:password])
       # session[:user_id] = @user.id guarda el id del usuario en la sesion para mantener la sesion iniciada.
       session[:user_id] = @user.id
       redirect_to productos_path, notice: "Bienvenido, #{@user.username}"
     else
       redirect_to new_session_path, alert: 'Email/Username o Password incorrecto'
     end
     
  end

  def destroy
    # session.delete(:user_id) elimina el id del usuario de la sesion para cerrar la sesion.
    session.delete(:user_id)
    redirect_to productos_path, notice: 'Has cerrado Sesion, vuelve pronto.'
  end


end