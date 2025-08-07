 
 class ProductosController < ApplicationController

  def index
  
    @productos= Producto.all # muestra todos los productos
  end

  def show
   @producto= Producto.find(params[:id]) # muestra un producto por id
  end

  def new
    @producto= Producto.new # crea una instancia del objeto Producto
  end

  def create 
    @producto= Producto.new(parametros_producto) # se pasa los parametros que estan en la funcion parametros_producto

   # pp @producto # muestra por pantalla el contenido de una variable

   if @producto.save
    # redirige a productos_path
      redirect_to productos_path , notice: 'Producto creado correctamente.'

   else
     render :new, status: :unprocessable_entity # renderiza nuevo y envia un error 422
   end

  end
  
  def edit
    @producto = Producto.find(params[:id])
  end

  def update
    @producto= Producto.find(params[:id])

    if @producto.update(parametros_producto)
        redirect_to productos_path, notice: 'Producto actualizado Correctamente'

    else
      render :edit, status: :unprocessable_entity

    end
  end

  def destroy
    @producto= Producto.find(params[:id])
    @producto.destroy

    redirect_to productos_path, notice: 'Producto Eliminado correctamente', status: :see_other
    # el status: :see_other se utiliza para redireccionar a otro producto y no al producto eliminado .

  end


  private
  # esta funcion devuelve los parametros de producto
  def parametros_producto
    params.require(:producto).permit(:titulo, :descripcion, :precio, :imagen) 
  end

 end