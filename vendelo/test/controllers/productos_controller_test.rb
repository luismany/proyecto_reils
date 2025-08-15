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

  test 'renderiza la pagina de nuevo con su formulario' do

    get new_producto_path
    assert_response :success
    assert_select 'form'

  end

  test 'Permite crear un nuevo Producto' do

    # espera un objeto producto con todos sus atributos
    post productos_path, params: {
      producto:{
        titulo:'nintendo 64',
        descripcion:'le faltan los cables',
        precio:45,
        categoria_id: categorias(:videojuegos).id # asigna la categoria al producto
      }
    }

    assert_redirected_to productos_path
    # espera que el mensaje del alert sea igual a este.
    assert_equal flash[:notice], 'Producto creado correctamente.' 
  end

  test 'no permite crear un nuevo producto con campos vacios' do  

    post productos_path, params: {
      producto:{
        titulo:'',
        descripcion:'le faltan los cables',
        precio:45
      }
    }

    assert_response :unprocessable_entity # espera que la respuesta sea un error 422

  end

   test 'renderiza la pagina de editar con su formulario' do

    get edit_producto_path(productos(:ps4))
    assert_response :success
    assert_select 'form'

  end

  test 'Permite actualizar un producto' do
    patch producto_path(productos(:ps4)), params:{
      producto:{
        precio:170
      }
    }
    assert_redirected_to productos_path
    assert_equal flash[:notice], 'Producto actualizado Correctamente'
  end

  test 'No permite actualizar un producto con un campo invalido' do

    patch producto_path(productos(:ps4)), params:{
      producto:{
        precio:nil
      }
    }
    assert_response :unprocessable_entity
  end

  test 'Permite eliminar productos' do

    assert_difference('Producto.count', -1) do
    delete producto_path(productos(:ps4))
    end

    assert_redirected_to productos_path
    assert_equal flash[:notice], 'Producto Eliminado correctamente'

  end



end

