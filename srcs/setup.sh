# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/04 13:10:14 by qurobert          #+#    #+#              #
#    Updated: 2021/03/26 13:33:20 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

# Setup Minikube
minikube stop
minikube delete
minikube start --driver=virtualbox
IP_MINIKUBE=$(minikube ip)
sed "s/MINIKUBEIP/$IP_MINIKUBE/g" srcs/metallb/metallb.template > srcs/metallb/metallb.yaml
sed "s/MINIKUBEIP/$IP_MINIKUBE/g" srcs/ftps/srcs/on.template > srcs/ftps/srcs/on.sh
sed "s/MINIKUBEIP/$IP_MINIKUBE/g" srcs/wordpress/srcs/user_template.sh > srcs/wordpress/srcs/user.sh
eval $(minikube docker-env)

# Setup MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb/.

function StartService()
{
    eval $(minikube docker-env)
    docker build -t $1-image ./srcs/$1/
    kubectl apply -f ./srcs/$1/config.yaml
}

# Start Services
StartService "influxdb"
StartService "mysql"
StartService "phpmyadmin"
sleep 5
StartService "nginx"
StartService "wordpress"
StartService "ftps"
StartService "grafana"
minikube dashboard
