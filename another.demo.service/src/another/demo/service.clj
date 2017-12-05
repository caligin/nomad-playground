(ns another.demo.service
  (:gen-class)
  (:require [ring.adapter.jetty :as ring-j]
            [ring.middleware.file :as ring-file]
            [clj-http.client :as http]))


(defn get-demo-service []
  (:body (http/get "http://haproxy.service.consul" {:headers {"host" "demoservice.service"}})))  

(defn make-get-resource []
  (fn [{:keys [uri]}]
    { :status 200
      :headers {"Content-Type" "text/plain"}
      :body (str "demo service says: " (get-demo-service))}))

(defn -main
  "Consumer"
  [& args]
  (let [port (or (first args) "4444")]
    (ring-j/run-jetty (make-get-resource) {:port (Integer/parseInt port)})))
