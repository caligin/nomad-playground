consul {
  auth {
    enabled  = false
  }
  address = "127.0.0.1:8500"
  ssl {
    enabled = false
  }
}

max_stale = "10m"
log_level = "warn"
pid_file = "/var/run/consul-template.pid"
wait {
  min = "5s"
  max = "10s"
}

syslog {
  enabled = true
}

template {
  source = "/etc/consul-template.d/haproxy-apps.tpl"
  destination = "/etc/haproxy/haproxy.cfg"
  command = "systemctl reload haproxy"
  command_timeout = "60s"
  backup = true
  left_delimiter  = "{{"
  right_delimiter = "}}"
  wait {
    min = "2s"
    max = "6s"
  }
}
