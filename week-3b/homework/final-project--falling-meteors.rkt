;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname final-project--falling-meteors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Meteors falling from the sky!

;; =================
;; Constants:
(define WIDTH 400)
(define HEIGHT 200)

(define MTS (empty-scene WIDTH HEIGHT))
(define METEOR-IMG (overlay (circle 35 "solid" "lightpurple") (circle 40 "solid" "purple")))

(define X-SPEED 1)
(define Y-SPEED 3)

;; =================
;; Data definitions:

(define-struct meteor (x y))
;; Meteor is (make-meteor Number Number)
;; interp. a meteor at coords x, y

(define METEOR-1 (make-meteor 50 20))

#;
(define (fn-for-meteor m)
  (... (meteor-x m)
       (meteor-y m)))
;; Templates rules used:
;;   - compound: 2 fields

;; =================
;; Functions:

;; Meteor -> Meteor
;; start the world with initial meteor, start with (main (make-meteor 0 0))
;; <no tests for main>
(define (main m)
  (big-bang m                     ; Meteor
    (on-tick   advance-meteor)    ; Meteor -> Meteor
    (to-draw   render)            ; Meteor -> Image
    (on-mouse  handle-mouse)))    ; Meteor Integer Integer MouseEvent -> Meteor

;; Meteor -> Meteor
;; increment meteor x by X-SPEED, and meteor y by Y-SPEED
(check-expect (advance-meteor (make-meteor 20 20)) (make-meteor (+ 20 X-SPEED) (+ 20 Y-SPEED)))

;(define (advance-meteor m) m) ; stub

; template from Meteor
(define (advance-meteor m)
  (make-meteor (+ (meteor-x m) X-SPEED)
               (+ (meteor-y m) Y-SPEED)))


;; Meteor -> Image
;; place METEOR-IMG at the correct coords on MTS
(check-expect (render (make-meteor 35 50)) (place-image METEOR-IMG 35 50 MTS))

;(define (render m) MTS) ; stub

; template from Meteor
(define (render m)
  (place-image METEOR-IMG
               (meteor-x m) (meteor-y m)
               MTS))

;; Meteor Integer Integer MouseEvent -> Meteor
;; move meteor to mouse click coords on button-down
(check-expect (handle-mouse (make-meteor 12 20) 70 20 "button-down") (make-meteor 70 20))
(check-expect (handle-mouse (make-meteor 70 20) 70 20 "button-down") (make-meteor 70 20))
(check-expect (handle-mouse (make-meteor 15 30) 45 18 "button-up")   (make-meteor 15 30))

;(define (handle-mouse m x y me) m)  ; stub

; template from on-mouse
(define (handle-mouse m x y me)
  (cond [(mouse=? me "button-down") (make-meteor x y)]
        [else m]))
