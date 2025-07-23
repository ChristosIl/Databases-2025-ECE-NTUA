<h1 align="center">Festival Management RDBMS</h1> 
<p align="center"> 
<!-- Node.js badge --> <a><img src="https://img.shields.io/badge/Node.js-v22.15.0-brightgreen" alt="Node.js"></a> 
<!-- npm badge --> <a><img src="https://img.shields.io/badge/npm-v10.9.2-blue" alt="npm"></a>
<!-- MariaDB badge --> <a><img src="https://img.shields.io/badge/Database-MariaDB-lightblue" alt="MariaDB"></a>
<!-- Express.js badge --> <a><img src="https://img.shields.io/badge/Framework-Express-black" alt="Express.js"></a> 
<!-- Docker badge --> <a><img src="https://img.shields.io/badge/Container-Docker-blue" alt="Docker"></a> 
<!-- EJS badge --> <a><img src="https://img.shields.io/badge/Template-EJS-yellow" alt="EJS"></a> </p> <p align="center">
<a href="#description">Description</a> • <a href="#technologies">Technologies</a> • <a href="#how-to-use">How To Use</a> • <a href="#assumptions">Assumptions</a> </p>

## Description

This project implements a relational database management system (RDBMS) for managing music festivals. Each festival consists of various events, which in turn include performances by solo artists or bands. Visitors must purchase a ticket to participate, and if an event is sold out, they can resell their ticket via the "Resale Queue" system.

## Technologies

    MariaDB: Used for the database implementation, deployed via Docker container.

    Node.js & Express: Used to build the backend, which handles queries and displays results.

    EJS (Embedded JavaScript): Used to render dynamic pages on the client side and present SQL query results in a user-friendly way.

    Docker: Used to consistently and easily deploy the database environment.

## How To Use

To clone and successfully run the application, you must have:

* Docker and Docker Compose installed.

```bash
# Clone this repository
$ git clone https://github.com/ChristosIl/Databases-2025.git

# Go into the project folder 

# Compose docker file
$ docker compose build

# Start containers
$ docker compose up -d



```

* Navigate to http://localhost:8080 to explore the database using Adminer (port 8080 is assigned to Adminer in compose.yaml).

* Navigate to http://localhost:4000 to access the frontend displaying the results of the SQL queries.

## Assumptions

----
* As part of the system design, we assumed that the Pulse University Festival may host multiple festivals, each with its own year, location, and characteristics.
Since the application starts in 2025, we assume that festivals begin in 2025. Therefore, we consider the 2025 festivals as the relevant participations, even if the year has already passed.
----
* It is assumed that a staff member cannot work at more than one event on the same day. This is enforced via appropriate insert logic and constraints using triggers.
----
* We applied the required constraints for staff assignments. For technical staff, however, no minimum requirement was defined. As a result, a scene may appear with 0 technical staff in queries or presentations (and that is acceptable).
----
* For queries related to artists, results are implemented to show data for solo artists. If band data is also required, the implementation approach is similar or identical.
----
* All requirements of the assignment have been met either through constraints or triggers.
