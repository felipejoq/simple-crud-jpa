<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simple Crud Jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-6">
            <div class="card text-center">
                <div class="card-header">
                    <h1>Simple Crud</h1>
                </div>
                <div class="card-body">
                    <p class="card-text">Acciones</p>
                    <ul class="list list-group">
                        <li class="list-group-item">
                            <a class="text-decoration-none" href="<%=request.getContextPath()%>/products">
                                Administrar productos
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="card-footer text-muted">
                    Felipe
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>