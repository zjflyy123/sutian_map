#!/bin/bash

set -e

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

export RED GREEN YELLOW RESET

cd "$(dirname "$0")" || exit
WORKDIR=$(pwd)
export WORKDIR
echo "current dir is: ${WORKDIR}"

IMAGE_DIR="${WORKDIR}/../images_pkg/"
ENV_FILE="${WORKDIR}/env/.env"
FRONTEND_COMPOSE="${WORKDIR}/frontend/frontend-compose.yml"
DATABASE_COMPOSE="${WORKDIR}/database/database-compose.yml"
DATABASE_COMPOSE="${WORKDIR}/database/database-compose.yml"
MAPTOOL_COMPOSE="${WORKDIR}/backend/maptool-compose.yml"
XTREME3D_COMPOSE="${WORKDIR}/backend/xtreme3d-compose.yml"

source ${ENV_FILE}

check_disk_available_space() {
	# Get the available disk space in the current directory, in units of GB.
	available_space=$(df -BG . | awk 'NR==2{print $4}' | sed 's/G//')

	# Check if the available disk space is greater than 40GB.
	if [[ "$available_space" -lt 40 ]]; then
		echo "${YELLOW} 当前目录可用磁盘空间小于 40G，请确保剩余空间大于 40G ${RESET}"
		exit 1
	fi
}

check_env_and_ports() {
    echo "${GREEN} =============== Checking .env file and ports =============== ${RESET}"

    # Read .env file and check each line.
    while IFS= read -r line; do
        # Skip empty lines and comments.
        [[ -z "$line" || "$line" =~ ^# ]] && continue

        # Split by the equals sign and exit if the value on the right side of the equals sign is empty.
        if [[ "$line" =~ = ]]; then
            key=$(echo "$line" | awk -F '=' '{print $1}')
            value=$(echo "$line" | awk -F '=' '{print $2}')
            if [[ -z "$value" ]]; then
                echo -e "${RED} ${key} is null, please configure the parameter value ${RESET}"
                exit 1
            fi

            # Check if the line contains a port variable and check if the port is in use.
            if [[ "$key" =~ _PORT$ ]]; then
                port="$value"
                if lsof -i :"$port" >/dev/null 2>&1; then
                    echo -e "${RED} ERROR: Port $port is already in use. ${RESET}"
                    exit 1
                fi
            fi
        fi
    done < "${ENV_FILE}"
}

load_images() {
	echo "${GREEN} =============== load images start =============== ${RESET}"
    for image in "$IMAGE_DIR"/*.tar; do
        echo "${GREEN} ===============>>>>>>> Loading image: $image ${RESET}"
        if ! docker load -i "$image"; then
            echo -e "${RED} ERROR: Failed to load image: $image ${RESET}" && exit 1
        fi
    done
}

start_docker_compose() {
    COMPOSE_FILES=(
        "${DATABASE_COMPOSE}"
        "${MAPTOOL_COMPOSE}"
		"${XTREME3D_COMPOSE}"
		"${FRONTEND_COMPOSE}"
    )

    for compose_file in "${COMPOSE_FILES[@]}"; do
        echo "${GREEN} ===============>>>>>>> Starting Docker Compose: $compose_file ${RESET}"
        if ! docker-compose -f "$compose_file" --env-file ${ENV_FILE} up -d; then
            echo -e "${RED} ERROR: Failed to start Docker Compose: $compose_file ${RESET}"
        else
            check_services_status "$compose_file"
        fi
    done
}

check_services_status() {
    compose_file=$1
    echo "${GREEN} =============== Checking services status for: $compose_file =============== ${RESET}"
    services=$(docker-compose -f "$compose_file" --env-file ${ENV_FILE} ps --services)
    
    for service in $services; do
        service_status=$(docker-compose -f "$compose_file" --env-file ${ENV_FILE} ps -q $service | xargs docker inspect -f '{{.State.Status}}')
        if [[ "$service_status" != "running" ]]; then
            echo -e "${RED} ERROR: Service $service in $compose_file failed to start. Status: $service_status ${RESET}"
            container_id=$(docker-compose -f "$compose_file" --env-file ${ENV_FILE} ps -q $service)
            echo "Logs for $service:"
            docker logs "$container_id"
        else
          echo -e "${GREEN} INFO: Service $service in $compose_file start successed . Status: $service_status ${RESET}"
        fi
    done
}

main() {
    #check_disk_available_space
    check_env_and_ports
    load_images     # 运行前需要导入tar包存放路径下的镜像
    start_docker_compose
    echo "${GREEN} ===============>>>>>>> Install finished. ${RESET}"
}

main
