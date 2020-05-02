(set-env!
 :source-paths #{"src/cljs" "src/clj" "src/cljc"}
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
                 [javax.servlet/javax.servlet-api "3.1.0"]
                 [org.clojars.magomimmo/valip "0.4.0-SNAPSHOT"]
                 [enlive "1.1.6"]
                 [adzerk/boot-test "1.2.0"]
                 [crisptrutski/boot-cljs-test "0.2.1-SNAPSHOT"]])     ;; for dev only 

(require '[adzerk.boot-cljs :refer [cljs]] ;; task cljs
         '[pandeiro.boot-http :refer [serve]] ;; make serve task visible
         '[adzerk.boot-reload :refer [reload]]
         '[adzerk.boot-cljs-repl :refer [cljs-repl start-repl]]
         '[adzerk.boot-test :refer [test]]
         '[crisptrutski.boot-cljs-test :refer [test-cljs]])

(def defaults {:test-dirs #{"test/cljc" "test/clj" "test/cljs"}
               :output-to "main.js"
               :testbed :phantom
               :namespaces '#{modern-cljs.shopping.validators-test
                              modern-cljs.login.validators-test}})

(deftask add-source-paths
  "Add paths to :source-paths environment variable"
  [t dirs PATH #{str} ":source-paths"]
  (merge-env! :source-paths dirs)
  identity)

(deftask tdd
  "Launch a customizable TDD Environment"
  [e testbed        ENGINE kw     "the JS testbed engine (default phantom)"
   k httpkit               bool   "Use http-kit web server (default jetty)"
   n namespaces     NS     #{sym} "the set of namespace symbols to run tests in"
   o output-to      NAME   str    "the JS output file name for test (default main.js)"
   O optimizations  LEVEL  kw     "the optimization level (default none)"
   p port           PORT   int    "the web server port to listen on (default 3000)"
   t dirs           PATH   #{str} "test paths (default test/clj test/cljs test/cljc)"
   v verbose               bool   "Print which files have changed (default false)"]
  (let [dirs        (or dirs (:test-dirs defaults))
        output-to   (or output-to (:output-to defaults))
        testbed     (or testbed (:testbed defaults))
        namespaces  (or namespaces (:namespaces defaults))]
    (comp
     (serve :handler 'modern-cljs.core/app
            :resource-root "target"
            :reload true
            :httpkit httpkit
            :port port)
     (add-source-paths :dirs dirs)
     (watch :verbose verbose)
     (reload :ws-host "localhost")
     (cljs-repl)
     (test-cljs :out-file output-to
                :js-env testbed
                :namespaces namespaces
                :update-fs? true
                :optimizations optimizations)
     (test :namespaces namespaces)
     (target :dir #{"target"}))))

(deftask dev
  "Launch immediate feedback dev environment"
  []
  (comp
   (serve :handler 'modern-cljs.core/app    ; ring handler
          :resource-root "target"           ; root classpath
          :reload true)                     ; reload ns
   (watch)
   (reload)
   (cljs-repl) ;; before cljs
   (cljs)
   (target :dir #{"target"})))
