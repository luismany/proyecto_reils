require 'test_helper'

class ProoductosControllerTest < ActionDispatch::IntegrationTest

  test 'renderisa una lista de productos' do

    get productos_path 
    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',2   # esperamos 2 productos que contengan la clase .producto
  end                             

  test 'renderiza la pagina detalle de producto' do

    get producto_path(productos(:ps4))
    assert_response :success
    assert_select '.titulo', 'ps4 fat'
    assert_select '.descripcion', 'ps3 en buen estado'
    assert_select '.precio', '150'


  end

end

