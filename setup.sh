# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/04 13:10:14 by qurobert          #+#    #+#              #
#    Updated: 2021/03/18 15:47:48 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Setup Minikube
minikube stop
minikube delete
minikube start --driver=virtualbox
IP_MINIKUBE=$(minikube ip)
sed "s/MINIKUBEIP/$IP_MINIKUBE/g" srcs/metallb/metallb.template > srcs/metallb/metallb.yaml
sed "s/MINIKUBEIP/$IP_MINIKUBE/g" srcs/ftps/srcs/on.template > srcs/ftps/srcs/on.sh
sed "s/MINIKUBEIP/$IP_MINIKUBE/g" srcs/influxdb/influxdb-config.template > srcs/influxdb/influxdb-config.yaml
eval $(minikube docker-env)

# Setup MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb/.

# Setup Nginx
docker build -t nginx-image ./srcs/nginx/
kubectl apply -f ./srcs/nginx/nginx.yaml

# Setup FTPS
eval $(minikube docker-env)
docker build -t ftps-image ./srcs/ftps/
kubectl apply -f ./srcs/ftps/ftps.yaml

# Setup InfluxDB
docker build -t influxdb-image ./srcs/influxdb/
kubectl apply -f ./srcs/influxdb/yaml

# Setup Grafana
docker build -t grafana-image ./srcs/grafana/
kubectl apply -f ./srcs/grafana/yaml

# Start minikube
minikube dashboard