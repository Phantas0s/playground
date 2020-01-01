(ns apples.core.desktop-launcher
  (:require [apples.core :refer :all])
  (:import [com.badlogic.gdx.backends.lwjgl LwjglApplication]
           [org.lwjgl.input Keyboard])
  (:gen-class))

(defn -main
  []
  (LwjglApplication. apples-game "apples" 1500 750)
  (Keyboard/enableRepeatEvents true))
