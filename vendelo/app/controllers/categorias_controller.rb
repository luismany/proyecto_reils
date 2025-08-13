class CategoriasController < ApplicationController
  
  def index
    @categorias = Categoria.all
  end

  def new 
    @categoria= Categoria.new
  end

  def create
    @categoria = Categoria.new(parametros_categoria)

    if @categoria.save
      redirect_to categorias_path, notice: 'Categoria creada correctamente.'
    else
      render :new, status: :unprocessable_entity
  end

  end

  def edit
    categoria
  end   

  def update
     
    if categoria.update(parametros_categoria)
      redirect_to categorias_path, notice: 'Categoria actualizada correctamente.' 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    categoria.destroy
    redirect_to categorias_path, notice: 'Categoria eliminada correctamente.', status: :see_other
  end


  private 

  def parametros_categoria
    params.require(:categoria).permit(:nombre)
  end

  def categoria
    @categoria = Categoria.find(params[:id])
  end


end