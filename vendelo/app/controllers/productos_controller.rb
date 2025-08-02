 
 class ProductosController < ApplicationController

  def index
  
    @productos= Producto.all # muestra todos los productos
  end

  def show
   @producto= Producto.find(params[:id]) # muestra un producto por id
  end

  def nuevo
    @producto= Producto.new # crea una instancia del objeto Producto
  end

  def crear 
    @producto= Producto.new(parametros_producto) # se pasa los parametros que estan en la funcion parametros_producto

   # pp @producto # muestra por pantalla el contenido de una variable

   if @producto.save
    # redirige a productos_path
      redirect_to productos_path , notice: 'Producto creado correctamente.'

   else
     render :nuevo, status: :unprocessable_entity # renderiza nuevo y envia un error 422
   end

  end
  
  def editar
    @producto = Producto.find(params[:id])
  end


  private
  # esta funcion devuelve los parametros de producto
  def parametros_producto
    params.require(:producto).permit(:titulo, :descripcion, :precio) 
  end

 end