(in-package #:ogl10)

(defvar *screen-width*  1000)
(defvar *screen-height* 800)
(defvar *background-color* '(0 0 0 1))
(defvar *drawing-color* '(1 1 1 1))

;; -------------------------------- ENGINE/MESH -------------------------------------

(defclass mesh ()
  ((vertices ; we do not need initform when we were loading vertex data from the file.  
              :accessor vertices
              :type (simple-vector 6)
              :allocation :class)
   (triangles ; we do not need initform when we were loading vertex data from the file.   
	      :accessor triangles
	      :type (simple-vector 6)
	      :allocation :class)
   (draw-type :initform :line-loop
	      :initarg :draw-type
	      :accessor draw-type
	      :type keyword
	      :allocation :class)))

(defgeneric draw (mesh))

(defmethod draw ((m mesh))
  (do ((i 0 (+ i 1)))
      ((> i (- (length (vertices m)) 3)) 'return-value)
    (gl:begin (draw-type m))
    (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
		(second (aref (vertices m) (aref (triangles m) i)))
		(third  (aref (vertices m) (aref (triangles m) i))))
    (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
    (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
    (gl:end)))

(defclass load-mesh (mesh)
  ((vertices :initform (make-array 5 :fill-pointer 0 :adjustable t)
	     :initarg :vertices
	     :accessor vertices
	     :allocation :instance)
   (triangles :initform (make-array 5 :fill-pointer 0 :adjustable t)
	      :initarg :triangles
	      :accessor triangles
	      :allocation :instance)
   (filename :initarg :filename
	     :accessor filename
	     :type string
	     :allocation :instance)
   (draw-type :initform :line-loop
	      :initarg :draw-type
	      :type keyword
	      :allocation :instance)))

(defmethod draw ((m load-mesh))
  (do ((i 0 (+ i 1)))
      ((> i (- (length (vertices m)) 3)) 'return-value)
    (gl:begin (draw-type m))
    (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
		(second (aref (vertices m) (aref (triangles m) i)))
		(third  (aref (vertices m) (aref (triangles m) i))))
    (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
    (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
    (gl:end)))

(defgeneric load-drawing (load-mesh))

(defmethod load-drawing ((m load-mesh))
  (with-open-file (stream (filename m))
    (do ((line (read-line stream nil)
	       (read-line stream nil)))
	((null line))
      (if (equal (str:substring 0 2 line) "v ")
	  (multiple-value-bind (vx vy vz)
	    (values (parse-float (second (str:words line)))
	            (parse-float (third (str:words line))) 
	            (parse-float (fourth (str:words line))))
	    (vector-push-extend `(,vx ,vy ,vz)
				(vertices m))))
      (if (equal (str:substring 0 2 line) "f ")
	  (multiple-value-bind (t1 t2 t3)
	      (multiple-value-bind (vx vy vz)
		(values (parse-integer (first (str:split "/" (second (str:words line)))))
		        (parse-integer (first (str:split "/" (third (str:words line))))) 
		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
		(values vx vy vz))
	    (vector-push-extend t1 (triangles m))
	    (vector-push-extend t2 (triangles m))
	    (vector-push-extend t3 (triangles m)))))))

(defmethod print-object ((obj load-mesh) stream)
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((vertices vertices)
		     (triangles triangles))
	obj
      (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; -------------------------------- ENGINE/MESH -------------------------------------

(defvar *mesh* (make-instance 'load-mesh :filename "cube.obj" :draw-type :line-loop))
;; (defvar *mesh* (make-instance 'load-mesh :filename "teapot.obj" :draw-type :line-loop))
;; (defvar *test*  (org.shirakumo.fraf.wavefront:parse #p"~/quicklisp/local-projects/ogl10/monkey.obj"))


(load-drawing *mesh*)

(defun initialize ()
  (gl:clear-color (first  *background-color*)
		  (second *background-color*)
		  (third  *background-color*)
		  (fourth *background-color*))
  (gl:color (first  *drawing-color*)
	    (second *drawing-color*)
	    (third  *drawing-color*)
	    (fourth *drawing-color*))
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 500.0))

(defvar *eye* (make-array 3 :initial-contents '(0 0 1)))

(defun init-camera ()  
  (gl:matrix-mode :modelview)
  (gl:load-identity)
  (gl:viewport 0 0 *screen-width* *screen-height*) 
  (gl:enable :depth-test)
  (glu:look-at (aref *eye* 0) (aref *eye* 1) (aref *eye* 2) 0 0 0 0 1 0))

(defun display ()
  (gl:clear :color-buffer-bit :depth-buffer-bit)
  (init-camera)
  (gl:push-matrix)
  (gl:translate 0 0 -4)
  (draw *mesh*)
  ;; (gl:load-identity)
  (gl:scale 0.5 0.5 0.5)
  (gl:translate -7 -5 -5)
  (draw *mesh*)
  (gl:pop-matrix))

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:gl-set-attr :doublebuffer 1)
    (sdl2:with-window (screen :w *screen-width* :h *screen-height*
			      :flags '(:opengl)
			      :title "OpenGL in Common Lisp")
      (sdl2:with-gl-context (gl-context screen)
	(progn
	  (initialize)
	  (sdl2:with-event-loop (:method :poll)
	    (:keydown (:keysym keysym)
		      (let ((scancode  (sdl2:scancode-value keysym))
			    (sym       (sdl2:sym-value keysym))
			    (mod-value (sdl2:mod-value keysym)))
			(declare (ignore sym mod-value))
			(cond
			  ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))
			  ((sdl2:scancode= scancode :scancode-down) (incf (aref *eye* 2)))
			  ((sdl2:scancode= scancode :scancode-up) (decf (aref *eye* 2)))
			  ((sdl2:scancode= scancode :scancode-left) (decf (aref *eye* 0)))
			  ((sdl2:scancode= scancode :scancode-right) (incf (aref *eye* 0)))
			  ((sdl2:scancode= scancode :scancode-q) (incf (aref *eye* 1)))
			  ((sdl2:scancode= scancode :scancode-w) (decf (aref *eye* 1))))))
	    (:idle ()
		   (display)
		   (sdl2:gl-swap-window screen)
		   ;; (sleep 0.100)
		   )
	    (:quit () t)))))))
