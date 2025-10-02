# current es una clase que utiliza ActiveSupport::CurrentAttributes para manejar atributos que son específicos de la solicitud actual, como el usuario autenticado.
# Esto es útil para evitar pasar el usuario actual a través de múltiples capas de la aplicación.
class Current < ActiveSupport::CurrentAttributes
  
  attribute :user

end