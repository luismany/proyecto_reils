class ApplicationController < ActionController::Base

  include Pagy::Backend

  # before_action es un filtro que se ejecuta antes de cada accion del controlador.

  before_action :establecer_usuario_actual
  before_action :paginas_protegidas

  private
  # establece el usuario actual en la variable Current.user si hay un usuario logueado (session[:user_id] existe).
  def establecer_usuario_actual
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # redirige a la pagina de login si no hay un usuario logueado.
  def paginas_protegidas
    redirect_to new_session_path, alert: 'Debes iniciar sesion para acceder a esta pagina' unless Current.user
  end
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
end
