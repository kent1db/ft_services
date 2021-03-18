# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/11 10:38:52 by qurobert          #+#    #+#              #
#    Updated: 2021/03/18 13:28:55 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update && apk add openrc --no-cache grafana --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache \
&& apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

EXPOSE 3000

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY grafana.db /usr/share/grafana/data/grafana.db

CMD (telegraf conf &) && grafana-server --homepath "/usr/share/grafana" start