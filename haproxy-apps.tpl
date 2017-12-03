global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    stats socket /var/lib/haproxy/stats

defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend  main *:80
    {{range $tag, $services := services | byTag}}{{if eq $tag "published"}}{{range $service := $services}}{{range service $service.Name}}use_backend {{.Name}}
    {{end}}{{end}}{{end}}{{end}}
    default_backend             empty

backend empty
    balance     roundrobin

{{range $tag, $services := services | byTag}}{{if eq $tag "published"}}{{range $service := $services}}
backend {{.Name}}
    balance     roundrobin
    {{range service $service.Name}}server  {{.Name}}-{{.Node}} {{.NodeAddress}}:{{.Port}} check inter 1000
    {{end}}
{{end}}{{end}}{{end}}
