
class Authentication::SessionsController < ApplicationController

  def new
    
  end

  def create
    # - Busca un usuario en la tabla users donde el email o el username coincidan con el valor que viene en params[:login].
    # - Si encuentra un usuario, lo asigna a la variable @user.
     @user= User.find_by("email = :login OR username = :login", {login: params[:login]})

     # Si encuentra un usuario y la autenticacion del password es correcta, guarda el id del usuario en la sesion y redirige a productos_path con un mensaje de exito.
     # @user&.authenticate(params[:password]) es una forma segura de llamar al metodo authenticate en caso de que @user sea nil.
     # Si no encuentra un usuario o la autenticacion del password es incorrecta, muestra un mensaje de error y renderiza la vista new con un estado de no procesable (422).
     # authenticate es un metodo proporcionado por has_secure_password que verifica si el password coincide con el password digest almacenado en la base de datos.
     if @user&.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to productos_path, notice: "Bienvenido, #{@user.username}"
     else
       redirect_to new_session_path, alert: 'Email/Username o Password incorrecto'
     end
     
  end


end