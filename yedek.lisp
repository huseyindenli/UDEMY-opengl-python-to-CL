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

(defvar *camera*)
(defclass camera ()
  ((eye     :initform (vector 0 0 0)
	    :accessor eye)
   (up      :initform (vector 0 1 0)
	    :accessor up)
   (right   :initform (vector 1 0 0)
	    :accessor right)
   (forward :initform (vector 0 0 1)
	    :accessor forward)
   (look    :accessor look)))

(defmethod initialize-instance :after ((obj camera) &key)
  (with-accessors ((eye eye) (forward forward) (look look)) obj
    (setf (look obj) (vector (+ (aref eye 0) (aref forward 0))
			     (+ (aref eye 1) (aref forward 1))
			     (+ (aref eye 2) (aref forward 2))))))

(defmethod update-data ((c camera) arg)
  (cond ((equal arg :down)  (progn (incf (aref (eye c) 0) (+ (aref (eye c) 0) (aref (forward c) 0)))
				   (incf (aref (eye c) 1) (+ (aref (eye c) 1) (aref (forward c) 1)))
				   (incf (aref (eye c) 2) (+ (aref (eye c) 2) (aref (forward c) 2)))))
	((equal arg :up)    (progn (incf (aref (eye c) 0) (- (aref (eye c) 0) (aref (forward c) 0)))
				   (incf (aref (eye c) 1) (- (aref (eye c) 1) (aref (forward c) 1)))
				   (incf (aref (eye c) 2) (- (aref (eye c) 2) (aref (forward c) 2)))))
	((equal arg :left)  (print "left"))
	((equal arg :right) (print "right")))
  (setf (aref (look c) 0) (+ (aref (eye c) 0) (aref (forward c) 0)))
  (setf (aref (look c) 1) (+ (aref (eye c) 1) (aref (forward c) 1)))
  (setf (aref (look c) 2) (+ (aref (eye c) 2) (aref (forward c) 2))))

(defmethod update-camera ((c camera))  
  (glu:look-at (aref (eye c)  0) (aref (eye c)  1) (aref (eye c)  2)
	       (aref (look c) 0) (aref (look c) 1) (aref (look c) 2)
	       (aref (up c)   0) (aref (up c)   1) (aref (up c)   2)))

;; -------------------------------- ENGINE/MESH -------------------------------------

(defvar *mesh* (make-instance 'load-mesh :filename "cube.obj" :draw-type :line-loop))
(defvar *camera* (make-instance 'camera))

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
  (gl:load-identity)
  (gl:viewport 0 0 *screen-width* *screen-height*) 
  (gl:enable :depth-test)
  )

(defun display ()
  (gl:clear :color-buffer-bit :depth-buffer-bit)
  (gl:push-matrix)
  (update-camera *camera*)
  (gl:translate 0 0 5)
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
			  ((sdl2:scancode= scancode :scancode-up)    (progn (update-data *camera* :up)))
			  ((sdl2:scancode= scancode :scancode-down)  (progn (update-data *camera* :down)))
			  ((sdl2:scancode= scancode :scancode-left)  (progn (update-data *camera* :left)))
			  ((sdl2:scancode= scancode :scancode-right) (progn (update-data *camera* :right))))))
	    (:idle ()
		   (display)
		   (sdl2:gl-swap-window screen)
		   ;; (sleep 0.100)
		   )
	    (:quit () t)))))))

;;;;;;;;;;;;;

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

(defvar *camera*)
(defclass camera ()
  ((eye     :initform (vector 0 0 0)
	    :accessor eye)
   (up      :initform (vector 0 1 0)
	    :accessor up)
   (right   :initform (vector 1 0 0)
	    :accessor right)
   (forward :initform (vector 0 0 1)
	    :accessor forward)
   (look    :accessor look)))

(defmethod initialize-instance :after ((obj camera) &key)
  (with-accessors ((eye eye) (forward forward) (look look)) obj
    (setf (look obj) (vector (+ (aref eye 0) (aref forward 0))
			     (+ (aref eye 1) (aref forward 1))
			     (+ (aref eye 2) (aref forward 2))))))

(defmethod update-data-down ()
  (incf (aref (eye *camera*) 0)  (+ (aref (eye *camera*) 0) (aref (forward *camera*) 0)))
  (incf (aref (eye *camera*) 1)  (+ (aref (eye *camera*) 1) (aref (forward *camera*) 1)))
  (incf (aref (eye *camera*) 2)  (+ (aref (eye *camera*) 2) (aref (forward *camera*) 2)))
  (setf (aref (look *camera*) 0) (+ (aref (eye *camera*) 0) (aref (forward *camera*) 0)))
  (setf (aref (look *camera*) 1) (+ (aref (eye *camera*) 1) (aref (forward *camera*) 1)))
  (setf (aref (look *camera*) 2) (+ (aref (eye *camera*) 2) (aref (forward *camera*) 2))))

(defmethod update-data-up ()  
  (incf (aref (eye *camera*) 0)  (- (aref (eye *camera*) 0) (aref (forward *camera*) 0)))
  (incf (aref (eye *camera*) 1)  (- (aref (eye *camera*) 1) (aref (forward *camera*) 1)))
  (incf (aref (eye *camera*) 2)  (- (aref (eye *camera*) 2) (aref (forward *camera*) 2)))  
  (setf (aref (look *camera*) 0) (+ (aref (eye *camera*) 0) (aref (forward *camera*) 0)))
  (setf (aref (look *camera*) 1) (+ (aref (eye *camera*) 1) (aref (forward *camera*) 1)))
  (setf (aref (look *camera*) 2) (+ (aref (eye *camera*) 2) (aref (forward *camera*) 2))))

(defmethod update-camera ()  
  (glu:look-at (aref (eye *camera*)  0) (aref (eye *camera*)  1) (aref (eye *camera*)  2)
	       (aref (look *camera*) 0) (aref (look *camera*) 1) (aref (look *camera*) 2)
	       (aref (up *camera*)   0) (aref (up *camera*)   1) (aref (up *camera*)   2)))

;; -------------------------------- ENGINE/MESH -------------------------------------

(defvar *mesh* (make-instance 'load-mesh :filename "cube.obj" :draw-type :line-loop))
(defvar *camera* (make-instance 'camera))

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
  (gl:load-identity)
  (gl:viewport 0 0 *screen-width* *screen-height*) 
  (gl:enable :depth-test)
  )

(defun display ()
  (gl:clear :color-buffer-bit :depth-buffer-bit)
  (gl:push-matrix)
  (update-camera)
  (gl:translate 0 0 5)
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
			(cond ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))
			      ((sdl2:scancode= scancode :scancode-up)     (update-data-up))
			      ((sdl2:scancode= scancode :scancode-down)   (update-data-down)))))
	    (:idle ()
		   (display)
		   (sdl2:gl-swap-window screen)
		   ;; (sleep 0.100)
		   )
	    (:quit () t)))))))

