(ns demo.service
  (:gen-class)
  (:require
  ;           [langohr.core      :as rmq]
  ;           [langohr.channel   :as lch]
  ;           [langohr.queue     :as lq]
  ;           [langohr.exchange  :as le]
  ;           [langohr.consumers :as lc]
  ;           [langohr.basic     :as lb]
  ;           [monger.core :as mg]
  ;           [monger.collection :as mc]
            [ring.adapter.jetty :as ring-j]
            [ring.middleware.file :as ring-file]
            [clj-http.client :as http]
            [cheshire.core :as json])
  (:import [com.mongodb MongoOptions ServerAddress WriteConcern]))

(defn id-from-uri [uri]
  (nth
    (re-matches #"^/([^/]+)/?$" uri)
    1))

(defn make-get-resource []
  (fn [{:keys [uri]}]
    { :status 200
      :headers {"Content-Type" "text/plain"}
      :body "ohai"}))

(defn -main
  "Consumer"
  [& args]
  (let [port (or (first args) "8888")]
    (ring-j/run-jetty (make-get-resource) {:port (Integer/parseInt port)})))
