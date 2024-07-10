(in-package #:ogl10)

(defvar *screen-width*  1000)
(defvar *screen-height* 800)
(defvar *background-color* '(0 0 0 1))
(defvar *drawing-color* '(1 1 1 1))

;; -------------------------------- ENGINE/MESH -------------------------------------

(defclass mesh ()
  ((vertices :initform #((0.5 -0.5 0.5)
			 (-0.5 -0.5 0.5)
			 (0.5 0.5 0.5)
			 (-0.5 0.5 0.5)
			 (0.5 0.5 -0.5)
			 (-0.5 0.5 -0.5))
	     :accessor vertices
	     :type (simple-vector 6)
	     :allocation :class)
   (triangles :initform #(0 2 3 0 3 1)
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

(defclass cube (mesh)
  ((vertices :initform #((0.5 -0.5 0.5)
			 (-0.5 -0.5 0.5)
			 (0.5 0.5 0.5)
			 (-0.5 0.5 0.5)
			 (0.5 0.5 -0.5)
			 (-0.5 0.5 -0.5)
			 (0.5 -0.5 -0.5)
			 (-0.5 -0.5 -0.5)
			 (0.5 0.5 0.5)
			 (-0.5 0.5 0.5)
			 (0.5 0.5 -0.5)
			 (-0.5 0.5 -0.5)
			 (0.5 -0.5 -0.5)
			 (0.5 -0.5 0.5)
			 (-0.5 -0.5 0.5)
			 (-0.5 -0.5 -0.5)
			 (-0.5 -0.5 0.5)
			 (-0.5 0.5 0.5)
			 (-0.5 0.5 -0.5)
			 (-0.5 -0.5 -0.5)
			 (0.5 -0.5 -0.5)
			 (0.5 0.5 -0.5)
			 (0.5 0.5 0.5)
			 (0.5 -0.5 0.5))
	     :accessor vertices
	     :type (simple-vector 24)
	     :allocation :class)
   (triangles :initform #(0 2 3 0 3 1 8 4 5 8 5 9 10 6 7 10 7 11 12 13 14
		          12 14 15 16 17 18 16 18 19 20 21 22 20 22 23)
	      :accessor triangles
	      :type (simple-vector 36)
	      :allocation :class)
   (draw-type :initarg :draw-type
	      :accessor draw-type
	      :type keyword
	      :allocation :class)))

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

      (if (equal (str:substring 0 2 line)
		 "v ")
	  (multiple-value-bind (vx vy vz)
	    (values (parse-float (second (str:words line)))
	            (parse-float (third (str:words line))) 
	            (parse-float (fourth (str:words line))))
	    (vector-push-extend `(,vx ,vy ,vz)
				(vertices m))))
      
      (if (equal (str:substring 0 2 line)
		 "f ")
	  (multiple-value-bind (t1 t2 t3)
	      (multiple-value-bind (vx vy vz)
		(values (parse-integer (first (str:split "/" (second (str:words line)))))
		        (parse-integer (first (str:split "/" (third (str:words line))))) 
		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
		
		(values vx vy vz))
	    ;; (vector-push-extend (make-array 5 :fill-pointer 0 :adjustable t) (vector-push-extend ...)
	    ;; oburturlusu olan #(#()) verir.
	    (vector-push-extend t1
				(triangles m))
	    (vector-push-extend t2
				(triangles m))
	    (vector-push-extend t3
				(triangles m)))))))

(defmethod print-object ((obj load-mesh) stream)
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((vertices vertices)
		     (triangles triangles))
	obj
      (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *cube* (make-instance 'cube :draw-type :line-loop)) ;; :line-loop or :polygon
(defvar *mesh* (make-instance 'load-mesh :filename "granny.obj" :draw-type :line-loop))

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
  (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 1000.0)
  (gl:matrix-mode :modelview)
  (gl:translate 0 0 -5)
  (gl:load-identity)
  (gl:viewport 0 0 *screen-width* *screen-height*) 
  (gl:enable :depth-test)
  (gl:translate 0 -100 -200)) ;; change x,y and z values -3 for different values and check the result.

(defun display ()
  (gl:clear :color-buffer-bit :depth-buffer-bit)
  (gl:rotate 1 10 0 1)
  (gl:push-matrix)
  ;; (draw *cube*) ;; LECTURE 29 the only diffference between Lec 29 and 30
  (draw *mesh*)    ;; LECTURE 30 the only diffference between Lec 29 and 30
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
			  ((sdl2:scancode= scancode :scancode-escape)
			   (sdl2:push-event :quit)))))
	    (:idle ()
		   (display)
		   (sdl2:gl-swap-window screen)
		   (sleep 0.100))
	    (:quit () t)))))))
