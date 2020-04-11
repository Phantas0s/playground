; another way
(use '[the-divine-cheese-code.visualization.svg :as svg :only [points]])
(refer 'the-divine-cheese-code.visualization.svg :as :only ['points])
(= svg/points points)
; => true

; ns is more used in production
; :refer-clojure take same options as refer function
(ns the-divine-cheese-code.core
  (:refer-clojure :exclude [println]))

(ns the-divine-cheese-code.core
  (:require the-divine-cheese-code.visualization.svg))
; equivalent to
; (in-ns 'the-divine-cheese-code.core)
; (require 'the-divine-cheese-code.visualization.svg)

;alias and multiple requires
(ns the-divine-cheese-code.core
  (:require [the-divine-cheese-code.visualization.svg :as svg]
            [clojure.java.browse :as browse]))
