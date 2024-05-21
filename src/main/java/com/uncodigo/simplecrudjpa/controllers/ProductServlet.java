package com.uncodigo.simplecrudjpa.controllers;

import com.uncodigo.simplecrudjpa.dao.IProductDao;
import com.uncodigo.simplecrudjpa.dao.impl.ProductDaoJpaImpl;
import com.uncodigo.simplecrudjpa.models.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "listProducts", value = "/products")
public class ProductServlet extends HttpServlet {
    private IProductDao productDao;

    @Override
    public void init() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("simple_crud_presis_unit");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        productDao = new ProductDaoJpaImpl(entityManager);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener todos los productos
        try {
            List<Product> products = productDao.readAll();
            req.setAttribute("products", products);

            req.getRequestDispatcher("products/list-products.jsp").forward(req, resp);
        } catch (Exception e) {
            // Set error to error.jps view
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));

            Product product = new Product();
            product.setName(name);
            product.setPrice(price);

            if (id == null || id.isEmpty()) {
                // Agregar un producto
                productDao.create(product);
                req.getSession().setAttribute("created", true);
            } else {
                // Actualizar un producto
                product.setId(Long.parseLong(id));
                productDao.update(product);
                req.getSession().setAttribute("updated", true);
            }

            // Redirigir a la lista de productos
            resp.sendRedirect(req.getContextPath() + "/products");
        } catch (Exception e) {
            // Set error to error.jps view
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("error.jsp");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String id = req.getParameter("id");
            // Eliminar un producto
            productDao.delete(Long.parseLong(id));
            req.setAttribute("deleted", true);

            this.doGet(req, resp);
        } catch (Exception e) {
            // Set error to error.jps view
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }

    @Override
    public void destroy() {
    }
}
