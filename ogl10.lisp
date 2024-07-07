(in-package #:ogl10)


(defvar *screen-width*  800)
(defvar *screen-height* 800)
(defvar *ortho-left* -400)
(defvar *ortho-right* 400)
(defvar *ortho-top* 0)
(defvar *ortho-bottom* 800)
(defvar *current-position* #(0 0))
(defvar *direction* #(0 1 0))

(defvar *instructions* "FF[+F][--FF][-F+F]")

(defvar *axiom* "F")
(defvar *rules* `(("F" . ,*instructions*)))
(defvar *draw-length* 10)
(defvar *angle* 25)
(defvar *stack* (make-array 5 :fill-pointer 0 :adjustable t))
(defvar *rule-run-number* 5)


(defun find-data (key-string rules)
  (cdr (assoc key-string rules :test #'equal)))

(defun replace-all (rules old-str new-str key-string)
  (str:replace-all old-str new-str (find-data key-string rules)))

(defun update-rules-generic (old-str new-str key-string)
  (setf (cdr (car *rules*)) (replace-all *rules* old-str new-str key-string)))

;; updates global *rules* variable (destructive)
(defun run-rule (times)
  (loop repeat (- times 1) do (update-rules-generic *axiom* *instructions* *axiom*))
  (print "Rule")
  (print *rules*))

(defun map-value (current-min current-max new-min new-max value)
  (let ((current-range (- current-max current-min))
	(new-range (- new-max new-min)))
    (+ new-min (* new-range (/ (- value current-min)
			       current-range)))))

(defun x-rotation (vector2 theta)
  (let ((new-vector (make-array '(3 3)
				:initial-contents
				`((1 0 0)
				  (0 ,(cos theta) ,(* -1 (sin theta)))
				  (0 ,(sin theta) ,(cos theta))))))
    (lla:mm new-vector vector2)))

(defun y-rotation (vector2 theta)
  (let ((new-vector (make-array '(3 3)
				:initial-contents
				`((,(cos theta) 0 ,(sin theta))
				  (0 1 0)
				  (,(* -1 (sin theta)) 0 ,(cos theta))))))
    (lla:mm new-vector vector2)))

(defun z-rotation (vector2 theta)
  (let ((new-vector (make-array '(3 3)
				:initial-contents
				`((,(cos theta) ,(* -1 (sin theta)) 0)
				  (,(sin theta) ,(cos theta) 0)
				  (0 0 1)))))
    (lla:mm new-vector vector2)))

(defun init-ortho ()
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))

(defun line-to (x y)
  (gl:begin :line-strip)
  (gl:vertex (aref *current-position* 0) (aref *current-position* 1))
  (gl:vertex x y)
  (setf *current-position* (vector x y))
  (gl:end))

;; (defun move-to (x y)
;;   (setf *current-position* (vector x y)))

(defun move-to (pos)
  (setf *current-position* (vector (aref pos 0) (aref pos 1))))

(defun reset-turtle ()
  (setf (aref *current-position* 0) 0)
  (setf (aref *current-position* 1) 0)
  (setf *direction* #(0 1 0)))

(defun do-draw-turtle (i)
  (cond ((equal i #\F) (forward *draw-length*))
	((equal i #\+) (rotate *angle*))
	((equal i #\-) (rotate (* -1 *angle*)))
	((equal i #\[) (progn (push *direction* *stack*)
			      (push *current-position* *stack*)))
	((equal i #\]) (progn (move-to (pop *stack*))
			      (setf *direction* (pop *stack*))))
	(t (rotate 0))))

(defun draw-turtle ()
  (loop for i across (find-data "F" *rules*) do (do-draw-turtle i)))
 
(defun forward (draw-length)
  (let ((new-x (+ (aref *current-position* 0)
		  (* (aref *direction* 0) draw-length)))
	(new-y (+ (aref *current-position* 1)
		  (* (aref *direction* 1) draw-length))))
    (line-to new-x new-y)))

(defun rotate (angle)
  (setf *direction* (z-rotation *direction* (* pi (/ angle 180.0)))))

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:gl-set-attr :doublebuffer 1)
    (sdl2:with-window (screen :w *screen-width* :h *screen-height*
			      :flags '(:opengl)
			      :title "Turtle Graphics")
      (sdl2:with-gl-context (gl-context screen)
	(progn
	  (init-ortho)
	  (gl:line-width 1)
	  (run-rule *rule-run-number*)
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
		   (gl:clear :color-buffer-bit :depth-buffer-bit)
		   (gl:matrix-mode :modelview)
		   (gl:load-identity)
		   (gl:begin :points)
		   (gl:vertex 0 0)
		   (gl:end)
		   (reset-turtle)
		   (draw-turtle)
		   (sdl2:gl-swap-window screen))
	    (:quit () t)))))))

