(set-env!
 :source-paths #{"src/cljs" "src/clj"}
 :resource-paths #{"html"}
 :dependencies '[[org.clojure/clojure "1.8.0"]         ;; add CLJ
                 [org.clojure/clojurescript "1.9.473"] ;; add CLJS
                 [adzerk/boot-cljs "2.1.5"]
                 [javax.xml.bind/jaxb-api "2.4.0-b180830.0359"] ;; fix bug
                 [pandeiro/boot-http "0.8.3"] ;; add http dependency
                 [adzerk/boot-reload "0.6.0"]
                 [adzerk/boot-cljs-repl   "0.4.0"] ;; latest release
                 [cider/piggieback        "0.3.9"  :scope "test"]
                 [weasel                  "0.7.0"  :scope "test"]
                 [nrepl                   "0.4.5"  :scope "test"]
                 [org.clojars.magomimmo/domina "2.0.0-SNAPSHOT"]
                 [hiccups "0.3.0"]
                 [compojure "1.5.2"] ; small CLJ routing library (server side)
                 [org.clojars.magomimmo/shoreleave-remote-ring "0.3.3"]
                 [org.clojars.magomimmo/shoreleave-remote "0.3.1"] ; Ajax RPC style
                 [javax.servlet/javax.servlet-api "3.1.0"]])     ;; for dev only 

(require '[adzerk.boot-cljs :refer [cljs]] ;; task cljs
         '[pandeiro.boot-http :refer [serve]] ;; make serve task visible
         '[adzerk.boot-reload :refer [reload]]
         '[adzerk.boot-cljs-repl :refer [cljs-repl start-repl]]) ;; make it visible

;; define dev task as composition of subtasks
(deftask dev
  "Launch Immediate Feedback Development Environment"
  []
  (comp
   (serve :handler 'modern-cljs.remotes/app            ;; ring handler
          :resource-root "target"            ;; add resource-path
          :reload true)
   (watch)
   (reload)
   (cljs-repl) ;; before cljs task
   (cljs)
   (target :dir #{"target"})))
