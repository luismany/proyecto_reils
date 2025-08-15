
require 'test_helper'

class CategoriasControllerTest < ActionDispatch::IntegrationTest

  test 'renderiza una lista de categorias' do
    get categorias_path
    assert_response :success
  
  end

  test 'renderiza la pagina de nuevo con su formulario' do
    get new_categoria_path
    assert_response :success
    assert_select 'form'
  end

  test 'Permite crear una nueva categoria' do 
    post categorias_path, params: {
      categoria:{
        nombre:'electronica' }}

        assert_redirected_to categorias_path
        assert_equal flash[:notice], 'Categoria creada correctamente.'
  end

  test 'no permite crear una nueva categoria con campos vacios' do
    post categorias_path, params: {
      categoria:{
        nombre:'' 
        }}
        assert_response :unprocessable_entity
  end

  test 'renderiza la pagina de editar con su formulario' do
    get edit_categoria_path(categorias(:informatica))
    assert_response :success
    assert_select 'form'
  end

  test 'Permite actualizar una categoria' do
    patch categoria_path(categorias(:informatica)), params: {
      categoria:{
        nombre:'informaticas' }}

    assert_redirected_to categorias_path
    assert_equal flash[:notice], 'Categoria actualizada correctamente.'
  end

  test 'No permite actualizar una categoria con un campo invalido' do
    patch categoria_path(categorias(:informatica)), params: {
      categoria:{
        nombre:'' }}  
        assert_response :unprocessable_entity
  end

  test 'Permite eliminar una categoria' do
    
    assert_difference('Categoria.count', -1) do
      delete categoria_path(categorias(:informatica))
    end

    assert_redirected_to categorias_path
    assert_equal flash[:notice], 'Categoria eliminada correctamente.'
  end

end