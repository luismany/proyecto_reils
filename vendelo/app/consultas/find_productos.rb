
class FindProductos
  # attr_reader crea un metodo de instancia que devuelve el valor de la variable de instancia @productos
  attr_reader :productos

# el constructor recibe un parametro productos que por defecto es el resultado de initial_scope
  def initialize(productos = initial_scope)
    @productos = productos
  end

  # el metodo call recibe un hash de parametros
  def call(params = {})

    scope= productos
    scope= filtrar_por_categoria_id(scope, params[:categoria_id])
    scope= filtrar_por_precio_min(scope, params[:precio_min])
    scope= filtrar_por_precio_max(scope, params[:precio_max])
    scope= filtrar_por_query_text(scope, params[:query_text])
    ordenar(scope, params[:order_by])

  end


  private

  def initial_scope
    Producto.all.with_attached_imagen
  end

  
  def filtrar_por_categoria_id(scope, categoria_id)
    # si category_id no esta presente, devuelve el scope original
    return scope unless categoria_id.present?
    # si category_id esta presente, filtra el scope por category_id
    scope.where(categoria_id: categoria_id)
  end

  def filtrar_por_precio_min(scope, precio_min)
    return scope unless precio_min.present?
  
    # filtra el scope por precio minimo
    scope.where('precio >= ?', precio_min)
  end

  def filtrar_por_precio_max(scope, precio_max)
    return scope unless precio_max.present?

    scope.where('precio <= ?', precio_max)
  end

  def filtrar_por_query_text(scope, query_text)
    return scope unless query_text.present?
  
    scope.search_full_text(query_text)
  end

  def ordenar(scope, order_by_param)
    order_by= Producto::ORDER_BY.fetch(order_by_param&.to_sym, Producto::ORDER_BY[:recientes])
    scope.order(order_by)
  end

end