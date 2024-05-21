package com.uncodigo.simplecrudjpa.dao;

import com.uncodigo.simplecrudjpa.models.Product;

import java.util.List;

public interface IProductDao {
    Product create(Product product);
    Product read(Long id);
    List<Product> readAll();
    Product update(Product product);
    void delete(Long id);
}
