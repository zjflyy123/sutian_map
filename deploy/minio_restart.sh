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
source ${ENV_FILE}

SERVERICE_COMPOSE="${WORKDIR}/database/minio-compose.yml"

stop_docker_compose() {
	echo "${GREEN} ===============>>>>>>> Stopping and removing Docker about Compose: ${SERVERICE_COMPOSE} ${RESET}"
	if ! docker-compose -f "${SERVERICE_COMPOSE}" --env-file ${ENV_FILE} down --rmi local; then
		echo "Failed to stop Docker Compose: ${SERVERICE_COMPOSE}"
	fi

}
start_docker_compose() {
	if ! docker-compose -f "${SERVERICE_COMPOSE}" --env-file ${ENV_FILE} up -d; then
		echo -e "${RED} ERROR: Failed to start Docker Compose: ${SERVERICE_COMPOSE} ${RESET}"
	else
		check_services_status "${SERVERICE_COMPOSE}"
	fi
}

check_services_status() {
    compose_file=$1
    services=$(docker-compose -f "$compose_file" --env-file ${ENV_FILE} ps --services)
    
    for service in $services; do
        service_status=$(docker-compose -f "$compose_file" --env-file ${ENV_FILE} ps -q $service | xargs docker inspect -f '{{.State.Status}}')
        if [[ "$service_status" != "running" ]]; then
            echo -e "${RED} ERROR: Service $service in $compose_file failed to start. Status: $service_status ${RESET}"
            container_id=$(docker-compose -f "$compose_file" --env-file ${ENV_FILE} ps -q $service)
            echo "Logs for $service:"
            docker logs "$container_id"
        else
          echo -e "${GREEN}Service $service start successed . Status: $service_status ${RESET}"
        fi
    done
}

main() {
    stop_docker_compose
    start_docker_compose
    echo "${GREEN} ===============>>>>>>> Install finished. ${RESET}"
}

main
