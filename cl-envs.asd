;;;; -*- Mode: LISP -*-

(in-package :asdf)

(defsystem :cl-envs
  :components
  ((:file "tiger"))
  :depends-on ("cl-utils" "agent-env" "cl-probability"))