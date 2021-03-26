# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/23 10:34:10 by qurobert          #+#    #+#              #
#    Updated: 2021/03/23 10:34:25 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

COPY ./srcs/script.sh /script.sh

RUN chmod +x /script.sh

RUN apk -U upgrade && \
apk add --no-cache \
openrc mysql mysql-client && \
rm -f /var/cache/apk/* && \
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY ./srcs/mariadb-server.cnf /etc/my.cnf.d/
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 3306

CMD sh script.sh