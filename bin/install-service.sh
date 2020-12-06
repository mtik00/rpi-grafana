#!/usr/bin/env bash
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_dir=$(readlink -f ${this_dir}/..)
compose_file=`readlink -f $(ls ../docker-compose*)`
docker_compose=$(which docker-compose)
env_dir="${base_dir}/env"
docker_compose_env_file="${base_dir}/.env"
service_file="${env_dir}/rpi-grafana.service"

# We're using `env` since it's ignored by .gitignore
mkdir -p ${env_dir}

echo "...creating ${service_file}"
cat << EOF > ${service_file}
[Unit]
Description=Grafana dashboard on an RPi!
Requires=docker.service
After=docker.service

[Service]
Environment="PWD=$PWD"
Restart=always
User=ubuntu
Group=docker
# Shutdown container (if running) when unit is stopped
ExecStartPre=${docker_compose}  --env-file ${docker_compose_env_file} -f ${compose_file} down -v
# Start container when unit is started
ExecStart=${docker_compose}  --env-file ${docker_compose_env_file} -f ${compose_file} up
# Stop container when unit is stopped
ExecStop=${docker_compose}  --env-file ${docker_compose_env_file} -f ${compose_file} down -v

[Install]
WantedBy=multi-user.target
EOF

echo "...linking ${service_file} to systemctl"
sudo systemctl link ${service_file} && sudo systemctl daemon-reload

echo "...enabling and starting service"
sudo systemctl enable rpi-grafana.service
sudo systemctl start rpi-grafana.service

echo "...complete"
echo "You can check the status of the service with 'sudo systemctl status rpi-grafana.service'"
