(ns apples.core
  (:require [play-clj.core :refer :all]
            [play-clj.g2d :refer :all]
            [play-clj.math :refer :all]))

(declare apples-game main-screen)
(def speed 15)

(defn- get-direction [screen]
  (cond
    (= (:key screen) (key-code :dpad-left)) :left
    (= (:key screen) (key-code :dpad-right)) :right))

; need the entire list of entity at the end of these functions
(defn- update-player-position [screen {:keys [player?] :as entity}]
  (if player?
    (let [scr screen
          direction (get-direction scr)
          new-x (case direction
                  :right (+ (:x entity) speed)
                  :left (- (:x entity) speed))]
      (when (not= (:direction entity) direction)
        (texture! entity :flip true false))
      (assoc entity :x new-x :direction direction))
    entity))

(defn- update-hit-box [{key [:player? :apple?] :as entity}]
  (if (or :player? :apple?)
   (assoc entity :hit-box (rectangle (:x entity) (:y entity) (:width entity) (:height entity)))
   entity))


; PROBLEM HERE (31:31 from the video)
(defn- move-player [screen entities]
  (map #(update-player-position screen %) entities)
  (map (update-hit-box) entities))

(defn- spawn-apple []
  (let [x (+ 50 (rand-int 1400))
        y (+ 50 (rand-int 30))]
    (assoc (texture "apple.png") :x x :y y :width 64 :height 64 :apple? true)))

(defscreen main-screen
  :on-show
  (fn [screen entities]
    (update! screen :renderer (stage))
    (add-timer! screen :spawn-apple 1 2)
    (let [background (texture "background.jpg")
          player (assoc (texture "cow.png") :x 50 :y 50 :width 400 :height 350 :player? true :direction :right)]
      [background player])) ; Order or rendering

  :on-render
  (fn [screen entities]
    (clear!)
    (render! screen entities))

  :on-key-down
  (fn [screen entities]
    (cond
      (= (:key screen) (key-code :r)) (on-gl (set-screen! apples-game main-screen))
      (get-direction screen) (move-player screen entities)
      :else entities))

  :on-timer
  (fn [screen entities]
    (case (:id screen)
      :spawn-apple (conj entities (spawn-apple)))))

(defgame apples-game
  :on-create
  (fn [this]
    (set-screen! this main-screen)))

(-> main-screen :entities deref)

; (on-gl (set-screen! apples-game main-screen))
