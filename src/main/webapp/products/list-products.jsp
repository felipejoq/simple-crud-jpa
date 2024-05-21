<%@ page import="com.uncodigo.simplecrudjpa.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Listado de productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-6">
            <div class="card text-center">
                <div class="card-header">
                    <h1>Listado de productos</h1>
                </div>
                <div class="card-body">
                    <% if (session.getAttribute("created") != null) { %>
                    <div class="alert alert-success" role="alert">
                        Producto creado correctamente
                    </div>
                    <% session.removeAttribute("created"); %>
                    <% } %>

                    <% if (session.getAttribute("updated") != null) { %>
                    <div class="alert alert-info" role="alert">
                        Producto actualizado correctamente
                    </div>
                    <% session.removeAttribute("updated"); %>
                    <% } %>

                    <!-- Tabla de productos con id, nombre, precio, acciones -->
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Precio</th>
                            <th scope="col">Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Product product : (List<Product>) request.getAttribute("products")) { %>
                        <tr>
                            <th scope="row"><%=product.getId()%></th>
                            <td><%=product.getName()%></td>
                            <td><%=product.getPrice()%></td>
                            <td>
                                <button
                                        class="edit-btn btn btn-primary"
                                        data-id="<%=product.getId()%>"
                                        data-name="<%=product.getName()%>"
                                        data-price="<%=product.getPrice()%>"
                                >
                                    Editar
                                </button>
                                <button
                                        data-id="<%=product.getId()%>"
                                        class="delete-btn btn btn-danger"
                                >
                                    Eliminar
                                </button>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                    <!-- Form para agregar productos -->
                    <form action="<%=request.getContextPath()%>/products" method="post">
                        <input type="hidden" id="id" name="id">
                        <div class="mb-3">
                            <label for="name" class="form-label">Nombre</label>
                            <input
                                    type="text"
                                    value=""
                                    class="form-control"
                                    id="name"
                                    name="name"
                                    required
                            >
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Precio</label>
                            <input type="number" class="form-control" id="price" name="price" required>
                        </div>
                        <button type="submit" id="submit-btn" class="btn btn-primary">Agregar</button>
                        <button type="button" id="cancel-btn" class="btn btn-secondary" style="display: none;">Cancelar</button>
                    </form>
                </div>
                <div class="card-footer text-muted">
                    <a href="<%=request.getContextPath()%>">Volver</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.querySelectorAll('.delete-btn').forEach(function(button) {
        button.addEventListener('click', async function(e) {
            e.preventDefault();
            const confirm = window.confirm('¿Estás seguro de eliminar este producto?');
            if(confirm) {
                const id = this.dataset.id;
                await fetch('<%=request.getContextPath()%>/products?id='+id, {
                    method: 'DELETE'
                });
                window.location.reload();
            }
        });
    });
    document.querySelectorAll('.edit-btn').forEach(function(button) {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const id = this.dataset.id;
            const name = this.dataset.name;
            const price = this.dataset.price;

            // Llenar el formulario con los datos del producto
            document.getElementById('id').value = id;
            document.getElementById('name').value = name;
            document.getElementById('price').value = price;

            // Cambiar el texto del botón de submit
            document.getElementById('submit-btn').textContent = 'Actualizar';

            // Mostrar el botón de cancelar
            document.getElementById('cancel-btn').style.display = 'inline-block';
        });
    });

    document.getElementById('cancel-btn').addEventListener('click', function(e) {
        e.preventDefault();

        // Limpiar el formulario
        document.getElementById('id').value = '';
        document.getElementById('name').value = '';
        document.getElementById('price').value = '';

        // Cambiar el texto del botón de submit
        document.getElementById('submit-btn').textContent = 'Agregar';

        // Ocultar el botón de cancelar
        this.style.display = 'none';
    });
</script>
</body>
</html>
