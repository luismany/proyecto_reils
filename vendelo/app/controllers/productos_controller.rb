 
 class ProductosController < ApplicationController

  def index
    @categorias= Categoria.all.order(nombre: :asc).load_async # muestra todas las categorias ordenadas alfabeticamente 
    #load_async se utiliza para cargar los registros de forma asincrona y mejorar el rendimiento de la aplicacion

    # muestra todos los productos
    @productos= Producto.all.with_attached_imagen.order(created_at: :desc).load_async
    # with_attached_imagen se utiliza para que Active Storage cargue las imágenes asociadas a los productos.
    # Esto es útil cuando se desea mostrar una lista de productos con sus imágenes en una vista.

    if params[:categoria_id]
      @productos= @productos.where(categoria_id: params[:categoria_id])
      # filtra los productos por categoria_id si se pasa como parametro
    end

    if params[:precio_min].present? 
      @productos= @productos.where("precio >= ?", params[:precio_min])
      # filtra los productos por precio minimo si se pasa como parametro
    end

    if params[:precio_max].present?
      @productos= @productos.where("precio <= ?", params[:precio_max])
      # filtra los productos por precio maximo si se pasa como parametro
    end

  end

  def show
   producto
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
    producto
  end

  def update

    if producto.update(parametros_producto)
        redirect_to productos_path, notice: 'Producto actualizado Correctamente'

    else
      render :edit, status: :unprocessable_entity

    end
  end

  def destroy
    
    producto.destroy

    redirect_to productos_path, notice: 'Producto Eliminado correctamente', status: :see_other
    # el status: :see_other se utiliza para redireccionar a otro producto y no al producto eliminado .

  end


  private
  # esta funcion devuelve los parametros de producto
  def parametros_producto
    params.require(:producto).permit(:titulo, :descripcion, :precio, :imagen, :categoria_id) 
  end

  def producto
    @producto = Producto.find(params[:id]) # muestra un producto por id
  end

 end