# 🐳 PFO2 - Dockerización de Aplicación Web PHP + MySQL

## 📘 Descripción del Proyecto
Este proyecto corresponde a la **Práctica Formativa Obligatoria N°2**, cuyo objetivo es:
- Comprender el funcionamiento y administración de contenedores Docker.
- Crear y conectar servicios web y de base de datos.
- Dockerizar un proyecto propio y publicarlo en Docker Hub y GitHub.

La aplicación muestra un listado de alumnos almacenados en una base de datos MySQL.

---

## 🧱 Estructura del Proyecto

```

pfo2-docker/
│
├── webapp/
│   ├── index.php              # Código PHP que se conecta a la base de datos
│
├── db/
│   ├── init.sql               # Script para inicializar la base y la tabla alumnos
│
├── Dockerfile                 # Imagen personalizada con PHP + Apache + MySQLi
├── docker-compose.yml         # Orquestación de servicios
├── .env                       # Variables de entorno (no subir al repo)
└── README.md                  # Este archivo

````

---

## ⚙️ Archivos principales

### 🐘 Dockerfile
```dockerfile
FROM php:8.2-apache
COPY ./webapp /var/www/html/
RUN docker-php-ext-install mysqli
````

### 🧩 docker-compose.yml

```yaml
services:
  web:
    build: .
    container_name: webserver
    ports:
      - "8080:80"
    depends_on:
      - db
    environment:
      DB_HOST: ${DB_HOST}
      DB_USER: ${DB_USER}
      DB_PASS: ${DB_PASS}
      DB_NAME: ${DB_NAME}
    restart: unless-stopped

  db:
    image: mysql:8.0
    container_name: mysql-db
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASS}
      MYSQL_DATABASE: ${DB_NAME}
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./db/init.sql:/docker-entrypoint-initdb.d/init.sql
    restart: unless-stopped

volumes:
  mysql_data:
```

### 🔒 .env (Ejemplo sin contraseñas)

```
DB_HOST= db_host
DB_USER=user
DB_PASS=pass
DB_NAME=pfo2
```

---

## 🚀 Cómo ejecutar el proyecto

### 1️⃣ Clonar el repositorio

```bash
git clone https://github.com/Manuel-Correderas/pfo2-docker.git
cd pfo2-docker
```

### 2️⃣ Crear el archivo `.env`

```bash
DB_HOST=db_host
DB_USER=user
DB_PASS=pass
DB_NAME=pfo2
```

### 3️⃣ Construir y levantar los contenedores

```bash
docker compose up --build -d
```

### 4️⃣ Verificar que los contenedores estén corriendo

```bash
docker ps
```

Deberías ver algo similar:

```
CONTAINER ID   NAMES        STATUS          PORTS
xxxxxx          webserver    Up              0.0.0.0:8080->80/tcp
xxxxxx          mysql-db     Up              0.0.0.0:3306->3306/tcp
```

### 5️⃣ Acceder a la aplicación

Abrí tu navegador en:
👉 [http://localhost:8080](http://localhost:8080)

---

## 🧠 Código PHP de conexión

```php
<?php
$host = getenv("DB_HOST");
$user = getenv("DB_USER");
$pass = getenv("DB_PASS");
$db   = getenv("DB_NAME");

$mysqli = new mysqli($host, $user, $pass, $db);

if ($mysqli->connect_errno) {
    echo "Error al conectar a MySQL: " . $mysqli->connect_error;
    exit();
}

$result = $mysqli->query("SELECT * FROM alumnos");
while ($row = $result->fetch_assoc()) {
    echo $row["nombre"] . " - " . $row["carrera"] . "<br>";
}
?>
```

---

## 🧩 Comandos Docker utilizados

| Comando                                                                            | Descripción                                     |
| ---------------------------------------------------------------------------------- | ----------------------------------------------- |
| `docker pull nginx`                                                                | Descarga la imagen base del servidor web Nginx. |
| `docker run -d --name webserver -p 8080:80 nginx`                                  | Crea el contenedor web.                         |
| `docker pull mysql:8.0`                                                            | Descarga la imagen de MySQL.                    |
| `docker run -d --name mysql-db -e MYSQL_ROOT_PASSWORD=1234 -p 3306:3306 mysql:8.0` | Ejecuta el contenedor MySQL.                    |
| `docker network create app-net`                                                    | Crea una red interna entre contenedores.        |
| `docker network connect app-net webserver`                                         | Conecta el webserver a la red.                  |
| `docker network connect app-net mysql-db`                                          | Conecta la base de datos.                       |
| `docker build -t pfo2-webapp .`                                                    | Construye la imagen PHP + Apache.               |
| `docker compose up --build -d`                                                     | Levanta los servicios definidos.                |

---

## 🐙 Publicación

* 📦 **Docker Hub:** [`dokicorrem/pfo2-webapp:v1`](https://hub.docker.com/r/dokicorrem/pfo2-webapp)
* 💻 **GitHub:** [`https://github.com/Manuel-Correderas/pfo2-docker`](https://github.com/Manuel-Correderas/pfo2-docker)

---

## 👨‍💻 Autor

**Manuel Correderas**
📚 Instituto de Formación Técnica Superior N° 29
📘  Materia: Desarrollo DevOps – PFO2
👨‍🏫 Profesor: Javier Blanco
👥 Equipo: Daniel Coria, María Nazar y Manuel Correderas
---

> ⚠️ **Nota:** No subir el archivo `.env` al repositorio.
> Se debe agregar en el `.gitignore` para proteger las credenciales.


