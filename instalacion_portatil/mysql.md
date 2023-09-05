  # MySql

  Para instalar mysql ejecutamos los siguientes comandos:

  ```
  sudo apt update
  sudo apt upgrade
  sudo apt install mysql-server mysql-client
  ```
  ## Acceder por primera vez

  ```
  sudo mysql -u root -p -h localhost
  ```

  # Crear superusuario
  ```
  CREATE USER 'my_user'@'localhost' IDENTIFIED BY 'my_password';
  GRANT ALL PRIVILEGES ON *.* TO 'my_user'@'localhost';
  FLUSH PRIVILEGES;
  ```


  * [Volver al Índice](./index.md)