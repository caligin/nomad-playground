(defproject another.demo.service "0.1.0-SNAPSHOT"
  :description "a demo service that uses some stuff we have available on our infra"
  :main another.demo.service
  :uberjar-name "another.demo.service.jar"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [ring/ring-core "1.6.2"]
                 [ring/ring-jetty-adapter "1.6.2"]
                 [clj-http "3.7.0"]])
