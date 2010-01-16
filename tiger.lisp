(defpackage :tiger
  (:use :cl :cl-utils :agent-env :cl-prob)
  (:export :tiger-env-model :left :right :listen :term))

(in-package :tiger)

(defclass tiger-env-model ()
  ())

(defmethod sample-initial ((m tiger-env-model))
  (sample '((left . .5) (right . .5))))

(defmethod sample-initial-observation ((m tiger-env-model) s)
  (declare (ignore s))
  nil)

(defun other-obs (s)
  (ecase s
    (left 'right)
    (right 'left)))

(defmethod sample-transition ((m tiger-env-model) s (a (eql 'listen)))
  (values (sample `((,s . .85) (,(other-obs s) . .15))) -1 s))

(defmethod sample-transition ((m tiger-env-model) s a)
  ;; left or right
  (values nil (if (eq s a) 10 -100) 'term))

(defmethod is-terminal-state ((m tiger-env-model) s)
  (eql s 'term))

(defmethod legal-action-list-at-state ((m tiger-env-model) s)
  (declare (ignore s))
  '(left right listen))