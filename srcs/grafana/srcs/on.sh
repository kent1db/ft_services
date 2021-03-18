mkdir etc/telegraf
mv telegraf.conf /etc/telegraf/
telegraf conf &
grafana-server --homepath "/usr/share/grafana" start