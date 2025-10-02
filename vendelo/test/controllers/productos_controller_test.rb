require 'test_helper'

class ProoductosControllerTest < ActionDispatch::IntegrationTest

  def setup
    login # llama al metodo login para iniciar sesion
  end

  test 'renderisa una lista de productos' do

    get productos_path 
    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',20   # esperamos 2 productos que contengan la clase .producto
    assert_select '.categoria',10 # esperamos 3 categorias que contengan la clase .categoria
  end   

  test 'renderisa una lista de productos filtrados por categoria' do

    get productos_path(categoria_id: categorias(:videogames).id ) # filtramos por la categoria informatica

    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',7   # esperamos 2 productos que contengan la clase .producto

  end  

   test 'renderisa una lista de productos filtrados por precio minimo y precio maximo' do

    get productos_path(precio_min: 160, precio_max: 200 ) 

    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',3   

  end  

     test 'Busca un producto filtrados por query_text' do

    get productos_path(query_text: 'ps4' ) 

    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',1   

  end  

   test 'Clasifica los producto por mas caros' do

    get productos_path(order_by: 'caros' ) 

    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',20 
    assert_select '.productos .producto:first-child h2', 'Seat Panda clásico' 

   end  

   test 'Clasifica los producto por mas barato' do

    get productos_path(order_by: 'baratos' ) 

    assert_response :success    # esperamos que la respuesta sea satisfactoria
    assert_select '.producto',20 
    assert_select '.productos .producto:first-child h2', 'El hobbit' 

   end  


    test 'renderiza la pagina detalle de producto' do

    get producto_path(productos(:ps4))
    assert_response :success
    assert_select '.titulo', 'PS4 Fat'
    assert_select '.descripcion', 'PS4 en buen estado'
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
        titulo:'PS4 Fat',
        descripcion:'PS4 en buen estado',
        precio:150,
        categoria_id: categorias(:videogames).id # asigna la categoria al producto
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

