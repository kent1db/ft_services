# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qurobert <qurobert@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/23 10:34:55 by qurobert          #+#    #+#              #
#    Updated: 2021/03/23 15:34:34 by qurobert         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

RUN apk update && \
    apk add wget && \
    apk add nginx openssl openrc php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-phar curl wget && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY srcs/ .

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 5050

CMD sh script.sh