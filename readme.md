This repository contains the source for a Dockerized version of the **Lattice Diamond** tool.
The objective is to simplify installation across different machines and to provide a consistent environment for development and verification automation.

---

## Requirements

- Docker
- Docker Compose plugin
- Git

---

## Building the Image

After cloning the repository locally, run the following command from the root of the cloned folder to build the image:

```bash
sudo docker build -t dennisloi/lattice_diamond_docker .
````

For details on what this step does, refer to the `Dockerfile`. In short, it:

* Uses a CentOS 7 base image
* Installs all required dependencies
* Downloads and installs Lattice Diamond
* Installs VUnit
* Configures the required environment variables

The container includes X11 support to allow running GUI applications if needed.

---

## Configuring the Container

The container is configured using `docker-compose.yml`, with most settings defined in a `.env` file.

An example file (`.env-example`) is provided. Copy or rename it to `.env` and update it with:

* The MAC address specified in the license file
* The path to the license file
* The host path used to access external files from the container

---

## Running the Container

### (Optional) Enable GUI Support

If you plan to run GUI applications, execute the following command on the host:

```bash
xhost +local:docker
```

### Start the Container

To start the container in detached mode:

```bash
sudo docker compose up -d
```

The container will start and run in the background.
To verify that it is running:

```bash
sudo docker ps
```

---

## Accessing the Container

Once the container is running, access it with:

```bash
sudo docker compose exec fpga bash
```
