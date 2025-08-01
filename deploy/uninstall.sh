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

ENV_FILE="${WORKDIR}/env/.env"
FRONTEND_COMPOSE="${WORKDIR}/frontend/frontend-compose.yml"
DATABASE_COMPOSE="${WORKDIR}/database/database-compose.yml"
MAPTOOL_COMPOSE="${WORKDIR}/backend/maptool-compose.yml"
XTREME3D_COMPOSE="${WORKDIR}/backend/xtreme3d-compose.yml"
FRONTEND_CACHE="${WORKDIR}/../frontend/maptool/html/"
DATABASE_CACHE="${WORKDIR}/../database"

# Stop and remove Docker Compose services.
stop_docker_compose() {
    COMPOSE_FILES=(
        "${FRONTEND_COMPOSE}"
        "${DATABASE_COMPOSE}"
        "${MAPTOOL_COMPOSE}"
		"${XTREME3D_COMPOSE}"
    )

    for compose_file in "${COMPOSE_FILES[@]}"; do
        echo "${GREEN} ===============>>>>>>> Stopping and removing Docker about Compose: $compose_file ${RESET}"
        if ! docker-compose -f "$compose_file" --env-file ${ENV_FILE} down --rmi local; then
            echo "Failed to stop Docker Compose: $compose_file"
        fi
    done
}

remove_chace_data() {
    # Delete database cache.
    if [ -d ${DATABASE_CACHE} ]; then
      echo "${YELLOW} ===============>>>>>>> Please input [root password] for delete database cache ! ${RESET}"
      # sudo rm -rf ${DATABASE_CACHE}
    fi

    # Delete frontend cache.
    if [ -d ${FRONTEND_CACHE} ]; then
		echo "${GREEN} ===============>>>>>>> Delete frontend cache. ${RESET}"
       # find "${FRONTEND_CACHE}" -type d -regextype posix-extended -regex '.*/[0-9]+' -exec sudo rm -rf {} +
    fi
}

main() {
	stop_docker_compose
	remove_chace_data
	echo "${GREEN} ===============>>>>>>> Uninstall finished. ${RESET}"
}

main
