# WSO2 API Manager with MySQL and NGINX Docker Setup

This repository contains a Docker Compose setup for running WSO2 API Manager (APIM) with MySQL databases and NGINX reverse proxy. The setup includes all necessary configurations for a complete API management environment.

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 1.29+

## Directory Structure

```
├── apim/                    # WSO2 API Manager configurations
│   └── repository/conf/     # Configuration files
├── mysql/                   # MySQL configurations and initialization scripts
│   ├── conf/                # MySQL configuration files
│   └── scripts/             # Database initialization SQL scripts
└── nginx/                   # NGINX configurations
    └── conf.d/              # NGINX site configurations
```

## Configuration

### WSO2 API Manager Configuration
The main configuration file is located at `apim/repository/conf/deployment.toml`. Key settings include:

- Hostname configured as `am-uat.example.com`
- Database connections to MySQL for both APIM and shared databases
- Gateway environment configured for hybrid (production and sandbox) traffic
- Endpoints configured for `api-uat.example.com`

### NGINX Configuration
Two configuration files in `nginx/conf.d/`:

1. `amwso2com.conf` - Handles reverse proxy for APIM publisher/store
2. `load_balancer.conf` - Defines upstream servers for load balancing

### MySQL Initialization Scripts
SQL scripts in `mysql/scripts/` create the necessary databases and tables for WSO2 API Manager.

## Usage

1. Clone this repository
2. Ensure you have SSL certificates in `nginx/ssl/` directory:
   - `amwso2com.crt` (certificate)
   - `amwso2com.key` (private key)
3. Run the services:
   ```bash
   docker-compose up -d
   ```
4. Access the services:
   - WSO2 API Manager Publisher/DevPortal: https://am-uat.example.com
   - API Gateway endpoints: https://api-uat.example.com

## Default Credentials

- WSO2 API Manager Admin Console:
  - Username: `admin`
  - Password: `admin`

- MySQL Root User:
  - Username: `root`
  - Password: `root`

- WSO2 Carbon Database User:
  - Username: `wso2carbon`
  - Password: `wso2carbon`

## Customization

To customize this setup for your environment:

1. Update hostnames in:
   - `apim/repository/conf/deployment.toml`
   - `nginx/conf.d/amwso2com.conf`
   - `nginx/conf.d/load_balancer.conf`

2. Replace SSL certificates in `nginx/ssl/` with your own certificates

3. Modify database credentials in:
   - `mysql/scripts/` SQL files
   - `apim/repository/conf/deployment.toml`

4. Adjust port mappings in `docker-compose.yml` if needed
