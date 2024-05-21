package com.uncodigo.simplecrudjpa.database.providers;

public interface IEnvsProvider {
    String host = "localhost";
    String port = "3306";
    String database = "simple_crud";
    String user = "root";
    String password = "123123";
    String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?serverTimezone=UTC";
}
