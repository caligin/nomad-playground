#!/bin/bash
cat > demo.service.nomad <<NOMAD
job "demo.service" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }

  group "demo.service" {
    count = 3
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }

    task "demo.service" {
      driver = "java"
      artifact {
        source = "http://172.28.128.41:8153/go/files/${GO_PIPELINE_NAME}/${GO_PIPELINE_COUNTER}/${GO_STAGE_NAME}/${GO_STAGE_COUNTER}/${GO_JOB_NAME}/demo.service.jar"
      }

      config {
        jar_path    = "local/demo.service.jar"
        args = ["\${NOMAD_PORT_web}"]
      }
      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 10
          port "web" {
            static = 3000
          }
        }
      }
      service {
        name = "demoservice"
        tags = ["global", "published"]
        port = "web"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
NOMAD