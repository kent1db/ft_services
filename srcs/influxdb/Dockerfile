# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/11 10:50:10 by qurobert          #+#    #+#              #
#    Updated: 2021/03/18 15:44:57 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update && apk add openrc --no-cache influxdb telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

CMD (telegraf conf &) && influxd run -config /etc/influxdb.conf