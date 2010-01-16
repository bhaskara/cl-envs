(defpackage :simple-pendulum
  (:use :cl :utils))

(in-package :simple-pendulum)

(defconstant 2pi (* 2 pi))
(defconstant gravity 9.8)

(defstruct (state (:conc-name nil) (:constructor make-state (theta dtheta)) (:type list))
  theta dtheta)

(defstruct (env (:conc-name nil) (:constructor create-env) (:type list))
  a b step-size i)

(defun make-env (l b step-size)
  (create-env :step-size step-size :b b :a (* gravity l) :i (/ l 12)))

  
(defun transition (s u env)
  (with-readers (theta dtheta) s
    (with-readers (step-size a b) env
      (make-state (mod (+ theta (* dtheta step-size)) *2pi*)
		  (+ dtheta (- u (* b dtheta) (* a (sin theta))))))))
	      