package com.uncodigo.simplecrudjpa.dao.impl;

import com.uncodigo.simplecrudjpa.dao.IProductDao;
import com.uncodigo.simplecrudjpa.models.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ProductDaoJpaImpl implements IProductDao {

    private final EntityManager entityManager;

    public ProductDaoJpaImpl(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    public Product create(Product product) {
        System.out.println("ProductDaoJpaImpl.create");
        entityManager.getTransaction().begin();
        entityManager.persist(product);
        entityManager.getTransaction().commit();
        return product;
    }

    @Override
    public Product read(Long id) {
        return entityManager.find(Product.class, id);
    }

    @Override
    public List<Product> readAll() {
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p", Product.class);
        return query.getResultList();
    }

    @Override
    public Product update(Product product) {
        entityManager.getTransaction().begin();
        Product productUpdated = entityManager.merge(product);
        entityManager.getTransaction().commit();
        return productUpdated;
    }

    @Override
    public void delete(Long id) {
        entityManager.getTransaction().begin();
        Product product = read(id);
        if (product != null) {
            entityManager.remove(product);
        }
        entityManager.getTransaction().commit();
    }
}
