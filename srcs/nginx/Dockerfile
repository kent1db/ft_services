# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/04 11:04:51 by qurobert          #+#    #+#              #
#    Updated: 2021/03/12 00:35:14 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update && apk add nginx openrc --no-cache openssl openssh \
&& apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

WORKDIR	.

COPY ./srcs/ .

EXPOSE 80 443

ENTRYPOINT ["sh", "./ssl/on.sh"]
