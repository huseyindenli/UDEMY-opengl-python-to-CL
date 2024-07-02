(in-package #:ogl10)

(defvar *screen-width*  800)
(defvar *screen-height* 800)
(defvar *ortho-left* -400)
(defvar *ortho-right* 400)
(defvar *ortho-top* -400)
(defvar *ortho-bottom* 400)
(defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))
(defvar *lines*  (make-array 5 :fill-pointer 0 :adjustable t))
(defvar *mouse-down* nil)


(defun map-value (current-min current-max new-min new-max value)
  (let ((current-range (- current-max current-min))
	(new-range (- new-max new-min)))
    (+ new-min (* new-range (/ (- value current-min)
			       current-range)))))

(defun init-ortho ()
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))

(defun plot-point ()
  (gl:begin :points)
  (loop for p across *points* do
    (gl:vertex (aref p 0) (aref p 1)))
  (gl:end))

(defun plot-lines ()
  (loop for l across *points* do
    (progn
      (gl:begin :line-strip)
      (loop for coords across l do
	(gl:vertex (aref coords 0) (aref coords 1)))
      (gl:end))))

(defun split-by-one-space (string)
  "Returns a list of substrings of string
    divided by ONE space each.
    Note: Two consecutive spaces will be seen as
    if there were an empty string between them."
  (loop for i = 0 then (1+ j)
        as j = (position #\Space string :start i)
        collect (subseq string i j)
        while j))

(defun save-drawing ()
  (with-open-file (f "drawing.txt" :direction :output
				   :if-exists :supersede
				   :if-does-not-exist :create)
    (write-sequence (concatenate 'string 
				 (write-to-string (length *points*))
				 (format nil "~C" #\linefeed))
		    f)
    (loop for l across *points* do
      (progn
	(write-sequence (concatenate 'string 
				     (write-to-string (length l))
				     (format nil "~C" #\linefeed))
			f)
	(loop for coords across l do
	  (write-sequence (concatenate 'string
				       (write-to-string (aref coords 0))
				       " "
				       (write-to-string (aref coords 1))
				       (format nil "~C" #\linefeed))
			  f)))))
  (princ "Drawings Saved"))

(defun load-drawing ()
  (with-open-file (stream "drawing.txt" :direction :input
					:if-does-not-exist :error)
    (let ((num-of-lines (parse-integer (read-line stream))))
      (setf *points* (make-array 5 :fill-pointer 0 :adjustable t))
      (loop for l below num-of-lines do
	(progn
	  (setf *lines* (make-array 5 :fill-pointer 0 :adjustable t))
	  (vector-push-extend *lines* *points*)
	  (let ((num-of-coords (parse-integer (read-line stream))))
	    (loop for coord-number below num-of-coords do
	      (progn (let ((px nil)
			   (py nil)
			   (pp (split-by-one-space (read-line stream)))) ; ?
		       (setf px (parse-integer (first pp)))
		       (setf py (parse-integer (second pp)))
		       (vector-push-extend (vector px py) *lines*)
		       (print px)
		       (print " ")
		       (print py))))))))))

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:gl-set-attr :doublebuffer 1)
    (sdl2:with-window (screen :w *screen-width* :h *screen-height*
			      :flags '(:opengl)
			      :title "OpenGL in Common Lisp")
      (sdl2:with-gl-context (gl-context screen)
	(progn
	  (init-ortho)
	  (gl:point-size 5)
	  (let ((p nil))
	    (sdl2:with-event-loop (:method :poll)
	      (:mousebuttondown ()
				(setf *mouse-down* t)
				(setf *lines* (make-array 5 :fill-pointer 0 :adjustable t))
				(vector-push-extend *lines* *points*))
	      (:mousebuttonup () (setf *mouse-down* nil))
	      (:mousemotion () (when *mouse-down*
				 (multiple-value-bind (val1 val2) (sdl2:mouse-state)
				   (progn
				     (setf p (vector val1 val2))
				     (vector-push-extend (vector (map-value 0 *screen-width* *ortho-left* *ortho-right* (aref p 0))
								 (map-value 0 *screen-height* *ortho-bottom* *ortho-top* (aref p 1)))
							 *lines*)))))
	      (:keydown (:keysym keysym)
			(let ((scancode  (sdl2:scancode-value keysym))
			      (sym       (sdl2:sym-value keysym))
			      (mod-value (sdl2:mod-value keysym)))
			  (declare (ignore sym mod-value))
			  (cond
			    ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))
			    ((sdl2:scancode= scancode :scancode-s) (save-drawing))
			    ((sdl2:scancode= scancode :scancode-l) (load-drawing)))))
	      (:idle ()
		     (gl:clear :color-buffer-bit :depth-buffer-bit)
		     (gl:matrix-mode :modelview)
		     (gl:load-identity)
		     (plot-lines)
		     (sdl2:gl-swap-window screen)
		     ;; (sleep 0.100)
		     )
	      (:quit () t))))))))
