;;;; ogl10.asd

(asdf:defsystem #:ogl10
  :description "Describe ogl10 here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :depends-on (:sdl2
	       :cl-glu
	       :cl-opengl
	       :lla
	       :numcl
	       :str)
  :serial t
  :components ((:file "package")
               (:file "ogl10")))


;; (ql:quickload :ogl10)(in-package :ogl10)(in-package :ogl10)(main)
