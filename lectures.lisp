

                                                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
							     ;; SECTION 3: BASIC GRAPHICS PRIMITIVES ;;
							     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 8. Testing OpenGL in PyCharm(sdl2 in our case)			 ;;
;; 										 ;;
;; (defvar *screen-width*  1000)						 ;;
;; (defvar *screen-height* 800)							 ;;
;; (defvar *vertices* #((0.5 -0.5 0.5)						 ;;
;; 		     (-0.5 -0.5 0.5)						 ;;
;; 		     (0.5 0.5 0.5)						 ;;
;; 		     (-0.5 0.5 0.5)						 ;;
;; 		     (0.5 0.5 -0.5)						 ;;
;; 		     (-0.5 0.5 -0.5)						 ;;
;; 		     (0.5 -0.5 -0.5)						 ;;
;; 		     (-0.5 -0.5 -0.5)						 ;;
;; 		     (0.5 0.5 0.5)						 ;;
;; 		     (-0.5 0.5 0.5)						 ;;
;; 		     (0.5 0.5 -0.5)						 ;;
;; 		     (-0.5 0.5 -0.5)						 ;;
;; 		     (0.5 -0.5 -0.5)						 ;;
;; 		     (0.5 -0.5 0.5)						 ;;
;; 		     (-0.5 -0.5 0.5)						 ;;
;; 		     (-0.5 -0.5 -0.5)						 ;;
;; 		     (-0.5 -0.5 0.5)						 ;;
;; 		     (-0.5 0.5 0.5)						 ;;
;; 		     (-0.5 0.5 -0.5)						 ;;
;; 		     (-0.5 -0.5 -0.5)						 ;;
;; 		     (0.5 -0.5 -0.5)						 ;;
;; 		     (0.5 0.5 -0.5)						 ;;
;; 		     (0.5 0.5 0.5)						 ;;
;; 		     (0.5 -0.5 0.5)))						 ;;
;; (defvar *triangles* #(0 2 3 0 3 1 8 4 5 8 5 9 10 6 7 10 7 11 12 13 14	 ;;
;; 		      12 14 15 16 17 18 16 18 19 20 21 22 20 22 23))		 ;;
;; (defvar *background-color* '(0 0 0 1))					 ;;
;; (defvar *drawing-color* '(1 1 1 1))						 ;;
;; 										 ;;
;; (defun wire-cube ()								 ;;
;;   (do ((i 0 (+ i 1)))							 ;;
;;       ((> i (- (length *triangles*) 3)) 'return-value)			 ;;
;;     (gl:begin :lines)							 ;;
;;     (gl:vertex  (first  (aref *vertices* (aref *triangles* i)))		 ;;
;; 		(second (aref *vertices* (aref *triangles* i)))			 ;;
;; 		(third  (aref *vertices* (aref *triangles* i))))		 ;;
;;     (gl:vertex  (first  (aref *vertices* (aref *triangles* (+ i 1))))	 ;;
;; 		(second (aref *vertices* (aref *triangles* (+ i 1))))		 ;;
;; 		(third  (aref *vertices* (aref *triangles* (+ i 1)))))		 ;;
;;     (gl:vertex  (first  (aref *vertices* (aref *triangles* (+ i 2))))	 ;;
;; 		(second (aref *vertices* (aref *triangles* (+ i 2))))		 ;;
;; 		(third  (aref *vertices* (aref *triangles* (+ i 2)))))		 ;;
;;     (gl:end)))								 ;;
;; 										 ;;
;; (defun initialize ()								 ;;
;;   (gl:clear-color (first  *background-color*)				 ;;
;; 		  (second *background-color*)					 ;;
;; 		  (third  *background-color*)					 ;;
;; 		  (fourth *background-color*))					 ;;
;;   (gl:color (first  *drawing-color*)						 ;;
;; 	    (second *drawing-color*)						 ;;
;; 	    (third  *drawing-color*)						 ;;
;; 	    (fourth *drawing-color*))						 ;;
;;   (gl:matrix-mode :projection)						 ;;
;;   (gl:load-identity)								 ;;
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 100.0)		 ;;
;;   (gl:matrix-mode :modelview)						 ;;
;;   (gl:translate 0 0 -5)							 ;;
;;   (gl:load-identity)								 ;;
;;   (gl:viewport 0 0 *screen-width* *screen-height*)				 ;;
;;   (gl:enable :depth-test)							 ;;
;;   (gl:translate 0 0 -2))							 ;;
;; 										 ;;
;; (defun display ()								 ;;
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)				 ;;
;;   (gl:rotate 1 10 0 10)							 ;;
;;   (gl:push-matrix)								 ;;
;;   (wire-cube)								 ;;
;;   (gl:pop-matrix))								 ;;
;; 										 ;;
;; (defun main ()								 ;;
;;   (sdl2:with-init (:everything)						 ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)					 ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*		 ;;
;; 			      :flags '(:opengl)					 ;;
;; 			      :title "OpenGL in Common Lisp")			 ;;
;;       (sdl2:with-gl-context (gl-context screen)				 ;;
;; 	(progn									 ;;
;; 	  (initialize)								 ;;
;; 	  (sdl2:with-event-loop (:method :poll)					 ;;
;; 	    (:keydown (:keysym keysym)						 ;;
;; 		      (let ((scancode  (sdl2:scancode-value keysym))		 ;;
;; 			    (sym       (sdl2:sym-value keysym))			 ;;
;; 			    (mod-value (sdl2:mod-value keysym)))		 ;;
;; 			(declare (ignore sym mod-value))			 ;;
;; 			(cond							 ;;
;; 			  ((sdl2:scancode= scancode :scancode-escape)		 ;;
;; 			   (sdl2:push-event :quit)))))				 ;;
;; 	    (:idle ()								 ;;
;; 		   (display)							 ;;
;; 		   (sdl2:gl-swap-window screen)					 ;;
;; 		   (sleep 0.100))						 ;;
;; 	    (:quit () t)))))))							 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 10. OpenGL Programming Basics.                                                                                                                          ;;
;;                                                                                                                                                                     ;;
;; (defvar *screen-width*  1000)	     								    							       ;;
;; (defvar *screen-height* 800)				    													       ;;
;; 																				       ;;
;; ;;; othographic projection that we will use for 2D.														       ;;
;; (defun init-ortho ()											    							       ;;
;;   (gl:matrix-mode :projection)																       ;;
;;   ;; clears everything done before (:projection).											    			       ;;
;;   (gl:load-identity) 																	       ;;
;;   (glu:ortho-2d 0 640 0 480))									    							       ;;
;; 													    							       ;;
;; (defun main ()											    							       ;;
;;   (sdl2:with-init (:everything)									    							       ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)								    							       ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*												       ;;
;; 			      :flags '(:opengl)															       ;;
;; 			      :title "OpenGL in Common Lisp")		    											       ;;
;;       (sdl2:with-gl-context (gl-context screen)							    							       ;;
;; 	(progn 	  											    							       ;;
;; 	  (init-ortho)											    							       ;;
;; 	  (sdl2:with-event-loop (:method :poll)								    	    						       ;;
;; 	    (:idle ()																		       ;;
;; 		   ;; we are clearing anything with colors that is in frame buffer										       ;;
;; 		   ;; and anything to do with 3D depth coordinates each time. In 2D										       ;;
;; 		   ;; there is no depth basically.														       ;;
;; 		   (gl:clear :color-buffer-bit :depth-buffer-bit)												       ;;
;; 		   ;; this basically setting up openGL to start drawing something										       ;;
;; 		   ;; in the model coordinate systems. Which are different from											       ;;
;; 		   ;; projection coordinate systems.														       ;;
;; 		   (gl:matrix-mode :modelview)															       ;;
;; 		   ;; clears everything done before (:modelview).											    	       ;;
;; 		   (gl:load-identity)																       ;;
;; 		   																		       ;;
;; 		   (gl:point-size 5) ; 5 pixels in size.													       ;;
;; 		   ; for every gl:begin you have to have a matching gl:end.									    		       ;;
;; 		   (gl:begin :points) 																       ;;
;; 		   (gl:vertex 100 50) 								    								       ;;
;; 		   (gl:vertex 630 450)								    								       ;;
;; 		   (gl:end)										    							       ;;
;; 		   																		       ;;
;; 		   (sdl2:gl-swap-window screen)								    							       ;;
;; 		   (sleep 0.100))									    							       ;;
;; 	    (:quit () t)))))))										    							       ;;
;; 																				       ;;
;; ;;; lower end of the screen is (0, 0) and vertical line is positive x-axis and										       ;;
;; ;;; horizontal line is our positive y-axis.															       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 11. Plotting Star Signs											       ;;
;; 															       ;;
;; ;;; actual pixel size that of the screen window that we are poping up						       ;;
;; ;;; is going to take up. 												       ;;
;; (defvar *screen-width*  1000)									    		       ;;
;; (defvar *screen-height* 800)				    								       ;;
;; 															       ;;
;; (defun draw-star (x y size)												       ;;
;;   (gl:point-size size)												       ;;
;;   (gl:begin :points)													       ;;
;;   (gl:vertex x y)													       ;;
;;   (gl:end))														       ;;
;; 															       ;;
;; (defun init-ortho ()											    		       ;;
;;   (gl:matrix-mode :projection)											       ;;
;;   (gl:load-identity)													       ;;
;;   ;; bottom left corner (0, 640) and upper right corner (0, 480).							       ;;
;;   ;; scale of the window in the order of the axis they are facing.							       ;;
;;   ;; (0, 640) is your x-axis and (0, 480) is your y-axis.								       ;;
;;   ;; left, right, bottom, top.											       ;;
;;   (glu:ortho-2d 0 640 0 480)												       ;;
;;   ;; (glu:ortho-2d 0 1000 0 800)											       ;;
;;   ;; now bottom left corner is (0, 1000) => upper left point is (0, 0)						       ;;
;;   ;; (glu:ortho-2d 0 1000 800 0)											       ;;
;;   )									    						       ;;
;; 													    		       ;;
;; (defun main ()											    		       ;;
;;   (sdl2:with-init (:everything)									    		       ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)								    		       ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*							       ;;
;; 			      :flags '(:opengl)										       ;;
;; 			      :title "OpenGL in Common Lisp")		    						       ;;
;;       (sdl2:with-gl-context (gl-context screen)							    		       ;;
;; 	(progn 	  											    		       ;;
;; 	  (init-ortho)											    		       ;;
;; 	  (sdl2:with-event-loop (:method :poll)								    	    	       ;;
;; 	    (:idle ()													       ;;
;; 		   (gl:clear :color-buffer-bit :depth-buffer-bit)							       ;;
;; 		   (gl:matrix-mode :modelview)										       ;;
;; 		   (gl:load-identity)											       ;;
;; 		   (draw-star 231 151 20)		   								       ;;
;; 		   (draw-star 257 253 20)		   								       ;;
;; 		   (draw-star 303 180 15)		   								       ;;
;; 		   (draw-star 443 228 20)		   								       ;;
;; 		   (draw-star 435 287 10)		   								       ;;
;; 		   (draw-star 385 315 20)		   								       ;;
;; 		   (draw-star 371 343 10)		   								       ;;
;; 		   (draw-star 397 377 10)		   								       ;;
;; 		   (draw-star 435 373 10)		   								       ;;
;; 		   (sdl2:gl-swap-window screen)								    		       ;;
;; 		   (sleep 0.100))									    		       ;;
;; 	    (:quit () t)))))))										    		       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 12. Points and Plotting Functions			     ;;
;; 									     ;;
;; (defvar *screen-width*  1000)					     ;;
;; (defvar *screen-height* 800)						     ;;
;; 									     ;;
;; (defun init-ortho ()							     ;;
;;   (gl:matrix-mode :projection)					     ;;
;;   (gl:load-identity)							     ;;
;;   (glu:ortho-2d 0 4 -1 1))						     ;;
;; 									     ;;
;; (defun plot-graph ()							     ;;
;;   (gl:begin :points)							     ;;
;;   (let ((data (numcl:arange 0 4 0.005)))				     ;;
;;     (loop for px across data do					     ;;
;;       (gl:vertex px (* (exp (* -1 px))				     ;;
;; 		       (cos (* 2 pi px))))))				     ;;
;;   (gl:end))								     ;;
;; 									     ;;
;; (defun main ()							     ;;
;;   (sdl2:with-init (:everything)					     ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)				     ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*	     ;;
;; 			      :flags '(:opengl)				     ;;
;; 			      :title "OpenGL in Common Lisp")		     ;;
;;       (sdl2:with-gl-context (gl-context screen)			     ;;
;; 	(progn								     ;;
;; 	  (init-ortho)							     ;;
;; 	  (gl:point-size 5)						     ;;
;; 	  (sdl2:with-event-loop (:method :poll)				     ;;
;; 	    (:idle ()							     ;;
;; 		   (gl:clear :color-buffer-bit :depth-buffer-bit)	     ;;
;; 		   (gl:matrix-mode :modelview)				     ;;
;; 		   (gl:load-identity)					     ;;
;; 		   (plot-graph)						     ;;
;; 		   (sdl2:gl-swap-window screen)				     ;;
;; 		   (sleep 0.100))					     ;;
;; 	    (:quit () t)))))))						     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 13. Plotting Points with a Mouse							 ;;
;; 												 ;;
;; (defvar *screen-width*  1000)								 ;;
;; (defvar *screen-height* 800)									 ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))				 ;;
;; 												 ;;
;; (defun init-ortho ()										 ;;
;;   (gl:matrix-mode :projection)								 ;;
;;   (gl:load-identity)										 ;;
;;   (glu:ortho-2d 0 1000 800 0))								 ;;
;; 												 ;;
;; (defun plot-point ()										 ;;
;;   (gl:begin :points)										 ;;
;;   (loop for p across *points* do								 ;;
;;     (gl:vertex (aref p 0) (aref p 1)))							 ;;
;;   (gl:end))											 ;;
;; 												 ;;
;; (defun main ()										 ;;
;;   (sdl2:with-init (:everything)								 ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)							 ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*				 ;;
;; 			      :flags '(:opengl)							 ;;
;; 			      :title "OpenGL in Common Lisp")					 ;;
;;       (sdl2:with-gl-context (gl-context screen)						 ;;
;; 	(progn											 ;;
;; 	  (init-ortho)										 ;;
;; 	  (gl:point-size 5)									 ;;
;; 	  (let ((p nil))									 ;;
;; 	    (sdl2:with-event-loop (:method :poll)						 ;;
;; 	      (:mousebuttondown () (multiple-value-bind (val1 val2) (sdl2:mouse-state)		 ;;
;; 				     (progn							 ;;
;; 				       (setf p (vector val1 val2))				 ;;
;; 				       (vector-push-extend p *points*))))			 ;;
;; 	      (:idle ()										 ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)				 ;;
;; 		     (gl:matrix-mode :modelview)						 ;;
;; 		     (gl:load-identity)								 ;;
;; 		     (plot-point)								 ;;
;; 		     (sdl2:gl-swap-window screen)						 ;;
;; 		     (sleep 0.100))								 ;;
;; 	      (:quit () t))))))))								 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 14. Mapping Values Between Coordinate Systems									        ;;
;; 																        ;;
;; (defvar *screen-width*  1000)												        ;;
;; (defvar *screen-height* 800)													        ;;
;; (defvar *ortho-width* 640)													        ;;
;; (defvar *ortho-height* 480)													        ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))								        ;;
;; 																        ;;
;; (defun map-value (current-min current-max new-min new-max value)								        ;;
;;   (let ((current-range (- current-max current-min))										        ;;
;; 	(new-range (- new-max new-min)))											        ;;
;;     (+ new-min (* new-range (/ (- value current-min)										        ;;
;; 			       current-range)))))										        ;;
;; 																        ;;
;; (defun init-ortho ()														        ;;
;;   (gl:matrix-mode :projection)												        ;;
;;   (gl:load-identity)														        ;;
;;   (glu:ortho-2d 0 *ortho-width* 0 *ortho-height*))										        ;;
;; 																        ;;
;; (defun plot-point ()														        ;;
;;   (gl:begin :points)														        ;;
;;   (loop for p across *points* do												        ;;
;;     (gl:vertex (aref p 0) (aref p 1)))											        ;;
;;   (gl:end))															        ;;
;; 																        ;;
;; (defun main ()														        ;;
;;   (sdl2:with-init (:everything)												        ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)											        ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*								        ;;
;; 			      :flags '(:opengl)											        ;;
;; 			      :title "OpenGL in Common Lisp")									        ;;
;;       (sdl2:with-gl-context (gl-context screen)										        ;;
;; 	(progn															        ;;
;; 	  (init-ortho)														        ;;
;; 	  (gl:point-size 5)													        ;;
;; 	  (let ((p nil))													        ;;
;; 	    (sdl2:with-event-loop (:method :poll)										        ;;
;; 	      (:mousebuttondown () (multiple-value-bind (val1 val2) (sdl2:mouse-state)						        ;;
;; 				     (progn											        ;;
;; 				       (setf p (vector val1 val2))								        ;;
;; 				       (vector-push-extend (vector (map-value 0 *screen-width*  0 *ortho-width* (aref p 0))	        ;;
;; 								   (map-value 0 *screen-height* *ortho-height* 0 (aref p 1)))	        ;;
;; 							   *points*))))								        ;;
;; 	      (:idle ()														        ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)								        ;;
;; 		     (gl:matrix-mode :modelview)										        ;;
;; 		     (gl:load-identity)												        ;;
;; 		     (plot-point)												        ;;
;; 		     (sdl2:gl-swap-window screen)										        ;;
;; 		     (sleep 0.100))												        ;;
;; 	      (:quit () t))))))))												        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 15. Drawing Lines Part 1												      ;;
;; 																      ;;
;; (defvar *screen-width*  1000)												      ;;
;; (defvar *screen-height* 800)													      ;;
;; (defvar *ortho-width* 640)													      ;;
;; (defvar *ortho-height* 480)													      ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))								      ;;
;; (defvar *mouse-down* nil)													      ;;
;; 																      ;;
;; (defun map-value (current-min current-max new-min new-max value)								      ;;
;;   (let ((current-range (- current-max current-min))										      ;;
;; 	(new-range (- new-max new-min)))											      ;;
;;     (+ new-min (* new-range (/ (- value current-min)										      ;;
;; 			       current-range)))))										      ;;
;; 																      ;;
;; (defun init-ortho ()														      ;;
;;   (gl:matrix-mode :projection)												      ;;
;;   (gl:load-identity)														      ;;
;;   (glu:ortho-2d 0 *ortho-width* 0 *ortho-height*))										      ;;
;; 																      ;;
;; (defun plot-point ()														      ;;
;;   (gl:begin :points)														      ;;
;;   (loop for p across *points* do												      ;;
;;     (gl:vertex (aref p 0) (aref p 1)))											      ;;
;;   (gl:end))															      ;;
;; 																      ;;
;; (defun plot-lines ()														      ;;
;;   (gl:begin :line-strip)													      ;;
;;   (loop for p across *points* do												      ;;
;;     (gl:vertex (aref p 0) (aref p 1)))											      ;;
;;   (gl:end))															      ;;
;; 																      ;;
;; (defun main ()														      ;;
;;   (sdl2:with-init (:everything)												      ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)											      ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*								      ;;
;; 			      :flags '(:opengl)											      ;;
;; 			      :title "OpenGL in Common Lisp")									      ;;
;;       (sdl2:with-gl-context (gl-context screen)										      ;;
;; 	(progn															      ;;
;; 	  (init-ortho)														      ;;
;; 	  (gl:point-size 5)													      ;;
;; 	  (let ((p nil))													      ;;
;; 	    (sdl2:with-event-loop (:method :poll)										      ;;
;; 	      (:mousebuttondown () (setf *mouse-down* t))									      ;;
;; 	      (:mousebuttonup () (setf *mouse-down* nil))									      ;;
;; 	      (:mousemotion () (when *mouse-down*										      ;;
;; 				 (multiple-value-bind (val1 val2) (sdl2:mouse-state)						      ;;
;; 				   (progn											      ;;
;; 				     (setf p (vector val1 val2))								      ;;
;; 				     (vector-push-extend (vector (map-value 0 *screen-width*  0 *ortho-width* (aref p 0))	      ;;
;; 								 (map-value 0 *screen-height* *ortho-height* 0 (aref p 1)))	      ;;
;; 							 *points*)))))								      ;;
;; 	      (:idle ()														      ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)								      ;;
;; 		     (gl:matrix-mode :modelview)										      ;;
;; 		     (gl:load-identity)												      ;;
;; 		     (plot-lines)												      ;;
;; 		     (sdl2:gl-swap-window screen)										      ;;
;; 		     ;; (sleep 0.100)												      ;;
;; 		     )														      ;;
;; 	      (:quit () t))))))))												      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 16. Drawing Lines Part 2												      ;;
;; 																      ;;
;; (defvar *screen-width*  1000)												      ;;
;; (defvar *screen-height* 800)													      ;;
;; (defvar *ortho-width* 640)													      ;;
;; (defvar *ortho-height* 480)													      ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))								      ;;
;; (defvar *lines* (make-array 5 :fill-pointer 0 :adjustable t))								      ;;
;; (defvar *mouse-down* nil)													      ;;
;; 																      ;;
;; (defun map-value (current-min current-max new-min new-max value)								      ;;
;;   (let ((current-range (- current-max current-min))										      ;;
;; 	(new-range (- new-max new-min)))											      ;;
;;     (+ new-min (* new-range (/ (- value current-min)										      ;;
;; 			       current-range)))))										      ;;
;; 																      ;;
;; (defun init-ortho ()														      ;;
;;   (gl:matrix-mode :projection)												      ;;
;;   (gl:load-identity)														      ;;
;;   (glu:ortho-2d 0 *ortho-width* 0 *ortho-height*))										      ;;
;; 																      ;;
;; (defun plot-point ()														      ;;
;;   (gl:begin :points)														      ;;
;;   (loop for p across *points* do												      ;;
;;     (gl:vertex (aref p 0) (aref p 1)))											      ;;
;;   (gl:end))															      ;;
;; 																      ;;
;; (defun plot-lines ()														      ;;
;;   (loop for l across *points* do												      ;;
;;     (progn 															      ;;
;;       (gl:begin :line-strip)													      ;;
;;       (loop for coords across l do												      ;;
;; 	(gl:vertex (aref coords 0) (aref coords 1)))										      ;;
;;       (gl:end))))														      ;;
;; 																      ;;
;; (defun main ()														      ;;
;;   (sdl2:with-init (:everything)												      ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)											      ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*								      ;;
;; 			      :flags '(:opengl)											      ;;
;; 			      :title "OpenGL in Common Lisp")									      ;;
;;       (sdl2:with-gl-context (gl-context screen)										      ;;
;; 	(progn															      ;;
;; 	  (init-ortho)														      ;;
;; 	  (gl:point-size 5)													      ;;
;; 	  (let ((p nil))													      ;;
;; 	    (sdl2:with-event-loop (:method :poll)										      ;;
;; 	      (:mousebuttondown ()												      ;;
;; 				(setf *mouse-down* t)										      ;;
;; 				(setf *lines* (make-array 5 :fill-pointer 0 :adjustable t))					      ;;
;; 				(vector-push-extend *lines* *points*))								      ;;
;; 	      (:mousebuttonup () (setf *mouse-down* nil))									      ;;
;; 	      (:mousemotion () (when *mouse-down*										      ;;
;; 				 (multiple-value-bind (val1 val2) (sdl2:mouse-state)						      ;;
;; 				   (progn											      ;;
;; 				     (setf p (vector val1 val2))								      ;;
;; 				     (vector-push-extend (vector (map-value 0 *screen-width*  0 *ortho-width* (aref p 0))	      ;;
;; 								 (map-value 0 *screen-height* *ortho-height* 0 (aref p 1)))	      ;;
;; 							 *lines*)))))								      ;;
;; 	      (:idle ()														      ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)								      ;;
;; 		     (gl:matrix-mode :modelview)										      ;;
;; 		     (gl:load-identity)												      ;;
;; 		     (plot-lines)												      ;;
;; 		     (sdl2:gl-swap-window screen)										      ;;
;; 		     ;; (sleep 0.100)												      ;;
;; 		     )														      ;;
;; 	      (:quit () t))))))))												      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 17. Drawing a Graph with Lines															   ;;
;; 																				   ;;
;; (defvar *screen-width*  800)												        				   ;;
;; (defvar *screen-height* 800)													        			   ;;
;; (defvar *ortho-left* 0)													        			   ;;
;; (defvar *ortho-right* 4)													        			   ;;
;; (defvar *ortho-top* -1)													        			   ;;
;; (defvar *ortho-bottom* 1)													        			   ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))								        			   ;;
;; 																        			   ;;
;; (defun map-value (current-min current-max new-min new-max value)								        			   ;;
;;   (let ((current-range (- current-max current-min))										        			   ;;
;; 	(new-range (- new-max new-min)))											        			   ;;
;;     (+ new-min (* new-range (/ (- value current-min)										        			   ;;
;; 			       current-range)))))										        			   ;;
;; 																        			   ;;
;; (defun init-ortho ()														        			   ;;
;;   (gl:matrix-mode :projection)												        			   ;;
;;   (gl:load-identity)														        			   ;;
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))										           ;;
;; 																        			   ;;
;; (defun plot-point ()														        			   ;;
;;   (gl:begin :points)														        			   ;;
;;   (loop for p across *points* do												        			   ;;
;;     (gl:vertex (aref p 0) (aref p 1)))											        			   ;;
;;   (gl:end))															        			   ;;
;; 																				   ;;
;; (defun plot-graph ()																		   ;;
;;   (gl:begin :line-strip)																	   ;;
;;   (let ((data (numcl:arange 0 4 0.005)))															   ;;
;;     (loop for px across data do																   ;;
;;       (gl:vertex px (* (exp (* -1 px))															   ;;
;; 		       (cos (* 2 pi px))))))															   ;;
;;   (gl:end))																			   ;;
;; 																				   ;;
;; (defun main ()							   											   ;;
;;   (sdl2:with-init (:everything)					   											   ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)				   											   ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height* 												   ;;
;; 			      :flags '(:opengl)			   												   ;;
;; 			      :title "OpenGL in Common Lisp")	   												   ;;
;;       (sdl2:with-gl-context (gl-context screen)			   											   ;;
;; 	(progn							   												   ;;
;; 	  (init-ortho)						   												   ;;
;; 	  (gl:point-size 5)					   												   ;;
;; 	  (let ((p nil))					   												   ;;
;; 	    (sdl2:with-event-loop (:method :poll)		   												   ;;
;; 	      (:mousebuttondown () (multiple-value-bind (val1 val2) (sdl2:mouse-state) 										   ;;
;; 				     (progn			   												   ;;
;; 				       (setf p (vector val1 val2)) 												   ;;
;; 				       (vector-push-extend (vector (map-value 0 *screen-width*  *ortho-left* *ortho-right* (aref p 0)) 				   ;;
;; 								   (map-value 0 *screen-height* *ortho-bottom* *ortho-top* (aref p 1))) 			   ;;
;; 							   *points*))))												   ;;
;; 	      (:idle ()						    												   ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit) 												   ;;
;; 		     (gl:matrix-mode :modelview)		    												   ;;
;; 		     (gl:load-identity)				    												   ;;
;; 		     (plot-graph)				    												   ;;
;; 		     (sdl2:gl-swap-window screen)		    												   ;;
;; 		     (sleep 0.100))				    												   ;;
;; 	      (:quit () t))))))))												        			   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 18. Saving a Line Graph to a Data File											        ;;
;; 																	        ;;
;; (defvar *screen-width*  800)														        ;;
;; (defvar *screen-height* 800)														        ;;
;; (defvar *ortho-left* -400)														        ;;
;; (defvar *ortho-right* 400)														        ;;
;; (defvar *ortho-top* -400)														        ;;
;; (defvar *ortho-bottom* 400)														        ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))									        ;;
;; (defvar *lines* (make-array 5 :fill-pointer 0 :adjustable t))									        ;;
;; (defvar *mouse-down* nil)									      					        ;;
;; 																	        ;;
;; (defun map-value (current-min current-max new-min new-max value)									        ;;
;;   (let ((current-range (- current-max current-min))											        ;;
;; 	(new-range (- new-max new-min)))												        ;;
;;     (+ new-min (* new-range (/ (- value current-min)											        ;;
;; 			       current-range)))))											        ;;
;; 																	        ;;
;; (defun init-ortho ()															        ;;
;;   (gl:matrix-mode :projection)													        ;;
;;   (gl:load-identity)															        ;;
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))								        ;;
;; 																	        ;;
;; (defun plot-point ()															        ;;
;;   (gl:begin :points)															        ;;
;;   (loop for p across *points* do													        ;;
;;     (gl:vertex (aref p 0) (aref p 1)))												        ;;
;;   (gl:end))																        ;;
;; 																	        ;;
;; (defun plot-lines ()															        ;;
;;   (loop for l across *points* do													        ;;
;;     (progn																        ;;
;;       (gl:begin :line-strip)														        ;;
;;       (loop for coords across l do													        ;;
;; 	(gl:vertex (aref coords 0) (aref coords 1)))											        ;;
;;       (gl:end))))															        ;;
;; 																	        ;;
;; (defun save-drawing ()														        ;;
;;   (with-open-file (f "drawing.txt" :direction :output										        ;;
;; 				   :if-exists :supersede										        ;;
;; 				   :if-does-not-exist :create)										        ;;
;;     (write-sequence (concatenate 'string 												        ;;
;; 				 (write-to-string (length *points*))									        ;;
;; 				 (format nil "~C" #\linefeed))										        ;;
;; 		    f)															        ;;
;;     (loop for l across *points* do													        ;;
;;       (progn																        ;;
;; 	(write-sequence (concatenate 'string 												        ;;
;; 				     (write-to-string (length l))									        ;;
;; 				     (format nil "~C" #\linefeed))									        ;;
;; 			f)														        ;;
;; 	(loop for coords across l do													        ;;
;; 	  (write-sequence (concatenate 'string												        ;;
;; 				       (write-to-string (aref coords 0))								        ;;
;; 				       " "												        ;;
;; 				       (write-to-string (aref coords 1))								        ;;
;; 				       (format nil "~C" #\linefeed))									        ;;
;; 			  f)))))													        ;;
;;   (princ "Drawings Saved"))														        ;;
;; 																	        ;;
;; (defun main ()															        ;;
;;   (sdl2:with-init (:everything)													        ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)												        ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*									        ;;
;; 			      :flags '(:opengl)												        ;;
;; 			      :title "OpenGL in Common Lisp")										        ;;
;;       (sdl2:with-gl-context (gl-context screen)											        ;;
;; 	(progn																        ;;
;; 	  (init-ortho)															        ;;
;; 	  (gl:point-size 5)														        ;;
;; 	  (let ((p nil))														        ;;
;; 	    (sdl2:with-event-loop (:method :poll)											        ;;
;; 	      (:mousebuttondown ()													        ;;
;; 				(setf *mouse-down* t)											        ;;
;; 				(setf *lines* (make-array 5 :fill-pointer 0 :adjustable t))						        ;;
;; 				(vector-push-extend *lines* *points*))									        ;;
;; 	      (:mousebuttonup () (setf *mouse-down* nil))										        ;;
;; 	      (:mousemotion () (when *mouse-down*											        ;;
;; 				 (multiple-value-bind (val1 val2) (sdl2:mouse-state)							        ;;
;; 				   (progn												        ;;
;; 				     (setf p (vector val1 val2))									        ;;
;; 				     (vector-push-extend (vector (map-value 0 *screen-width* *ortho-left* *ortho-right* (aref p 0))	        ;;
;; 								 (map-value 0 *screen-height* *ortho-bottom* *ortho-top* (aref p 1)))	        ;;
;; 							 *lines*)))))									        ;;
;; 	      (:keydown (:keysym keysym)												        ;;
;; 			(let ((scancode  (sdl2:scancode-value keysym))									        ;;
;; 			      (sym       (sdl2:sym-value keysym))									        ;;
;; 			      (mod-value (sdl2:mod-value keysym)))									        ;;
;; 			  (declare (ignore sym mod-value))										        ;;
;; 			  (cond														        ;;
;; 			    ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))					        ;;
;; 			    ((sdl2:scancode= scancode :scancode-s) (save-drawing)))))							        ;;
;; 	      (:idle ()															        ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)									        ;;
;; 		     (gl:matrix-mode :modelview)											        ;;
;; 		     (gl:load-identity)													        ;;
;; 		     (plot-lines)													        ;;
;; 		     (sdl2:gl-swap-window screen)											        ;;
;; 		     ;; (sleep 0.100)													        ;;
;; 		     )															        ;;
;; 	      (:quit () t))))))))													        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 19. Loading a Line from a Data File											        ;;
;; 																	        ;;
;; (defvar *screen-width*  800)														        ;;
;; (defvar *screen-height* 800)														        ;;
;; (defvar *ortho-left* -400)														        ;;
;; (defvar *ortho-right* 400)														        ;;
;; (defvar *ortho-top* -400)														        ;;
;; (defvar *ortho-bottom* 400)														        ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))									        ;;
;; (defvar *lines*  (make-array 5 :fill-pointer 0 :adjustable t))									        ;;
;; (defvar *mouse-down* nil)														        ;;
;; 																	        ;;
;; 																	        ;;
;; (defun map-value (current-min current-max new-min new-max value)									        ;;
;;   (let ((current-range (- current-max current-min))											        ;;
;; 	(new-range (- new-max new-min)))												        ;;
;;     (+ new-min (* new-range (/ (- value current-min)											        ;;
;; 			       current-range)))))											        ;;
;; 																	        ;;
;; (defun init-ortho ()															        ;;
;;   (gl:matrix-mode :projection)													        ;;
;;   (gl:load-identity)															        ;;
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))								        ;;
;; 																	        ;;
;; (defun plot-point ()															        ;;
;;   (gl:begin :points)															        ;;
;;   (loop for p across *points* do													        ;;
;;     (gl:vertex (aref p 0) (aref p 1)))												        ;;
;;   (gl:end))																        ;;
;; 																	        ;;
;; (defun plot-lines ()															        ;;
;;   (loop for l across *points* do													        ;;
;;     (progn																        ;;
;;       (gl:begin :line-strip)														        ;;
;;       (loop for coords across l do													        ;;
;; 	(gl:vertex (aref coords 0) (aref coords 1)))											        ;;
;;       (gl:end))))															        ;;
;; 																	        ;;
;; (defun split-by-one-space (string)													        ;;
;;   "Returns a list of substrings of string												        ;;
;;     divided by ONE space each.													        ;;
;;     Note: Two consecutive spaces will be seen as											        ;;
;;     if there were an empty string between them."											        ;;
;;   (loop for i = 0 then (1+ j)													        ;;
;;         as j = (position #\Space string :start i)											        ;;
;;         collect (subseq string i j)													        ;;
;;         while j))															        ;;
;; 																	        ;;
;; (defun save-drawing ()														        ;;
;;   (with-open-file (f "drawing.txt" :direction :output										        ;;
;; 				   :if-exists :supersede										        ;;
;; 				   :if-does-not-exist :create)										        ;;
;;     (write-sequence (concatenate 'string 												        ;;
;; 				 (write-to-string (length *points*))									        ;;
;; 				 (format nil "~C" #\linefeed))										        ;;
;; 		    f)															        ;;
;;     (loop for l across *points* do													        ;;
;;       (progn																        ;;
;; 	(write-sequence (concatenate 'string 												        ;;
;; 				     (write-to-string (length l))									        ;;
;; 				     (format nil "~C" #\linefeed))									        ;;
;; 			f)														        ;;
;; 	(loop for coords across l do													        ;;
;; 	  (write-sequence (concatenate 'string												        ;;
;; 				       (write-to-string (aref coords 0))								        ;;
;; 				       " "												        ;;
;; 				       (write-to-string (aref coords 1))								        ;;
;; 				       (format nil "~C" #\linefeed))									        ;;
;; 			  f)))))													        ;;
;;   (princ "Drawings Saved"))														        ;;
;; 																	        ;;
;; (defun load-drawing ()														        ;;
;;   (with-open-file (stream "drawing.txt" :direction :input										        ;;
;; 					:if-does-not-exist :error)									        ;;
;;     (let ((num-of-lines (parse-integer (read-line stream))))										        ;;
;;       (setf *points* (make-array 5 :fill-pointer 0 :adjustable t))									        ;;
;;       (loop for l below num-of-lines do												        ;;
;; 	(progn																        ;;
;; 	  (setf *lines* (make-array 5 :fill-pointer 0 :adjustable t))									        ;;
;; 	  (vector-push-extend *lines* *points*)												        ;;
;; 	  (let ((num-of-coords (parse-integer (read-line stream))))									        ;;
;; 	    (loop for coord-number below num-of-coords do										        ;;
;; 	      (progn (let ((px nil)													        ;;
;; 			   (py nil)													        ;;
;; 			   (pp (split-by-one-space (read-line stream)))) ; ?								        ;;
;; 		       (setf px (parse-integer (first pp)))										        ;;
;; 		       (setf py (parse-integer (second pp)))										        ;;
;; 		       (vector-push-extend (vector px py) *lines*)									        ;;
;; 		       (print px)													        ;;
;; 		       (print " ")													        ;;
;; 		       (print py))))))))))												        ;;
;; 																	        ;;
;; (defun main ()															        ;;
;;   (sdl2:with-init (:everything)													        ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)												        ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*									        ;;
;; 			      :flags '(:opengl)												        ;;
;; 			      :title "OpenGL in Common Lisp")										        ;;
;;       (sdl2:with-gl-context (gl-context screen)											        ;;
;; 	(progn																        ;;
;; 	  (init-ortho)															        ;;
;; 	  (gl:point-size 5)														        ;;
;; 	  (let ((p nil))														        ;;
;; 	    (sdl2:with-event-loop (:method :poll)											        ;;
;; 	      (:mousebuttondown ()													        ;;
;; 				(setf *mouse-down* t)											        ;;
;; 				(setf *lines* (make-array 5 :fill-pointer 0 :adjustable t))						        ;;
;; 				(vector-push-extend *lines* *points*))									        ;;
;; 	      (:mousebuttonup () (setf *mouse-down* nil))										        ;;
;; 	      (:mousemotion () (when *mouse-down*											        ;;
;; 				 (multiple-value-bind (val1 val2) (sdl2:mouse-state)							        ;;
;; 				   (progn												        ;;
;; 				     (setf p (vector val1 val2))									        ;;
;; 				     (vector-push-extend (vector (map-value 0 *screen-width* *ortho-left* *ortho-right* (aref p 0))	        ;;
;; 								 (map-value 0 *screen-height* *ortho-bottom* *ortho-top* (aref p 1)))	        ;;
;; 							 *lines*)))))									        ;;
;; 	      (:keydown (:keysym keysym)												        ;;
;; 			(let ((scancode  (sdl2:scancode-value keysym))									        ;;
;; 			      (sym       (sdl2:sym-value keysym))									        ;;
;; 			      (mod-value (sdl2:mod-value keysym)))									        ;;
;; 			  (declare (ignore sym mod-value))										        ;;
;; 			  (cond														        ;;
;; 			    ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))					        ;;
;; 			    ((sdl2:scancode= scancode :scancode-s) (save-drawing))							        ;;
;; 			    ((sdl2:scancode= scancode :scancode-l) (load-drawing)))))							        ;;
;; 	      (:idle ()															        ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)									        ;;
;; 		     (gl:matrix-mode :modelview)											        ;;
;; 		     (gl:load-identity)													        ;;
;; 		     (plot-lines)													        ;;
;; 		     (sdl2:gl-swap-window screen)											        ;;
;; 		     ;; (sleep 0.100)													        ;;
;; 		     )															        ;;
;; 	      (:quit () t))))))))													        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Lecture 20. Polygons									 ;;
;; 												 ;;
;; (defvar *screen-width*  1000)								 ;;
;; (defvar *screen-height* 800)									 ;;
;; (defvar *points* (make-array 5 :fill-pointer 0 :adjustable t))				 ;;
;; 												 ;;
;; (defun init-ortho ()										 ;;
;;   (gl:matrix-mode :projection)								 ;;
;;   (gl:load-identity)										 ;;
;;   (glu:ortho-2d 0 1000 800 0))								 ;;
;; 												 ;;
;; ;; (defun plot-polygon ()									 ;;
;; ;;   (gl:color 0.2 0.2 0.2)									 ;;
;; ;;   (gl:begin :quad-strip)									 ;;
;; ;;   (loop for p across *points* do								 ;;
;; ;;     (gl:vertex (aref p 0) (aref p 1)))							 ;;
;; ;;   (gl:end))										 ;;
;; 												 ;;
;; (defun plot-polygon ()									 ;;
;;   (gl:color 0.2 0.2 0.2)									 ;;
;;   (gl:begin :triangles)									 ;;
;;   (loop for p across *points* do								 ;;
;;     (gl:vertex (aref p 0) (aref p 1)))							 ;;
;;   (gl:end)											 ;;
;;   (gl:color 0.5 0.5 0.5)									 ;;
;;   (loop for i from 0 to (- (length *points*) 3) by 3 do  					 ;;
;;     (progn ;(gl:begin :triangles)								 ;;
;;       (gl:begin :line-loop)									 ;;
;;       (gl:vertex (aref (aref *points* i) 0)       (aref (aref *points* i) 1))		 ;;
;;       (gl:vertex (aref (aref *points* (+ i 1)) 0) (aref (aref *points* (+ i 1)) 1))		 ;;
;;       (gl:vertex (aref (aref *points* (+ i 2)) 0) (aref (aref *points* (+ i 2)) 1))		 ;;
;;       (gl:end))))										 ;;
;; 												 ;;
;; (defun main ()										 ;;
;;   (sdl2:with-init (:everything)								 ;;
;;     (sdl2:gl-set-attr :doublebuffer 1)							 ;;
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*				 ;;
;; 			      :flags '(:opengl)							 ;;
;; 			      :title "OpenGL in Common Lisp")					 ;;
;;       (sdl2:with-gl-context (gl-context screen)						 ;;
;; 	(progn											 ;;
;; 	  (init-ortho)										 ;;
;; 	  (gl:line-width 3)									 ;;
;; 	  (let ((p nil))									 ;;
;; 	    (sdl2:with-event-loop (:method :poll)						 ;;
;; 	      (:mousebuttondown () (multiple-value-bind (val1 val2) (sdl2:mouse-state)		 ;;
;; 				     (progn							 ;;
;; 				       (setf p (vector val1 val2))				 ;;
;; 				       (vector-push-extend p *points*))))			 ;;
;; 	      (:idle ()										 ;;
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)				 ;;
;; 		     (gl:matrix-mode :modelview)						 ;;
;; 		     (gl:load-identity)								 ;;
;; 		     (plot-polygon)								 ;;
;; 		     (sdl2:gl-swap-window screen)						 ;;
;; 		     (sleep 0.100))								 ;;
;; 	      (:quit () t))))))))								 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	      ;;
;; ;; SECTION 4: TURTLE GRAPHICS ;;	      ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; sudo apt-get install libblas-dev liblapack-dev for :lla library


;;; LECTURE 21. PROGRAMMING A TURTLE
;; (defvar *screen-width*  800)
;; (defvar *screen-height* 800)
;; (defvar *ortho-left* -400)
;; (defvar *ortho-right* 400)
;; (defvar *ortho-top* -400)
;; (defvar *ortho-bottom* 400)
;; (defvar *current-position* #(0 0))
;; (defvar *direction* #(0 1 0))
;; (defvar *draw-length* 50)


;; (defun map-value (current-min current-max new-min new-max value)
;;   (let ((current-range (- current-max current-min))
;; 	(new-range (- new-max new-min)))
;;     (+ new-min (* new-range (/ (- value current-min)
;; 			       current-range)))))

;; (defun x-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3) :initial-contents `((1 0 0)
;; 							   (0 ,(cos theta) ,(* -1 (sin theta)))
;; 							   (0 ,(sin theta) ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun y-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3) :initial-contents `((,(cos theta) 0 ,(sin theta))
;; 							   (0 1 0)
;; 							   (,(* -1 (sin theta)) 0 ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun z-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3) :initial-contents `((,(cos theta) ,(* -1 (sin theta)) 0)
;; 							   (,(sin theta) ,(cos theta) 0)
;; 							   (0 0 1)))))
;;     (lla:mm new-vector vector2)))

;; (defun init-ortho ()
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))

;; (defun line-to (x y)
;;   (gl:begin :line-strip)
;;   (gl:vertex (aref *current-position* 0) (aref *current-position* 1))
;;   (gl:vertex x y)
;;   (setf *current-position* (vector x y))
;;   (gl:end))
  
;; (defun reset-turtle ()
;;   (setf (aref *current-position* 0) 0)
;;   (setf (aref *current-position* 1) 0)
;;   (setf *direction* #(0 1 0)))

;; (defun draw-turtle ()
;;   (forward)
;;   (forward))
 
;; (defun forward ()
;;   (let ((new-x (+ (aref *current-position* 0)
;; 		  (* (aref *direction* 0) *draw-length*)))
;; 	(new-y (+ (aref *current-position* 1)
;; 		  (* (aref *direction* 1) *draw-length*))))
;;     (line-to new-x new-y)))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "Turtle Graphics")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (init-ortho)
;; 	  (gl:line-width 5)
;; 	  (let ((p nil))
;; 	    (sdl2:with-event-loop (:method :poll)
;; 	      (:keydown (:keysym keysym)
;; 			(let ((scancode  (sdl2:scancode-value keysym))
;; 			      (sym       (sdl2:sym-value keysym))
;; 			      (mod-value (sdl2:mod-value keysym)))
;; 			  (declare (ignore sym mod-value))
;; 			  (cond
;; 			    ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit)))))
;; 	      (:idle ()
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)
;; 		     (gl:matrix-mode :modelview)
;; 		     (gl:load-identity)
;; 		     (gl:begin :points)
;; 		     (gl:vertex 0 0)
;; 		     (gl:end)
;; 		     (reset-turtle)
;; 		     (draw-turtle)
;; 		     (sdl2:gl-swap-window screen))
;; 	      (:quit () t))))))))

;;; LECTURE 22. ROTATING AND MOVING THE TURTLE
;; (defvar *screen-width*  800)
;; (defvar *screen-height* 800)
;; (defvar *ortho-left* -400)
;; (defvar *ortho-right* 400)
;; (defvar *ortho-top* -400)
;; (defvar *ortho-bottom* 400)
;; (defvar *current-position* #(0 0))
;; (defvar *direction* #(0 1 0))


;; (defun map-value (current-min current-max new-min new-max value)
;;   (let ((current-range (- current-max current-min))
;; 	(new-range (- new-max new-min)))
;;     (+ new-min (* new-range (/ (- value current-min)
;; 			       current-range)))))

;; (defun x-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3) :initial-contents `((1 0 0)
;; 							   (0 ,(cos theta) ,(* -1 (sin theta)))
;; 							   (0 ,(sin theta) ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun y-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3) :initial-contents `((,(cos theta) 0 ,(sin theta))
;; 							   (0 1 0)
;; 							   (,(* -1 (sin theta)) 0 ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun z-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3) :initial-contents `((,(cos theta) ,(* -1 (sin theta)) 0)
;; 							   (,(sin theta) ,(cos theta) 0)
;; 							   (0 0 1)))))
;;     (lla:mm new-vector vector2)))

;; (defun init-ortho ()
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))

;; (defun line-to (x y)
;;   (gl:begin :line-strip)
;;   (gl:vertex (aref *current-position* 0) (aref *current-position* 1))
;;   (gl:vertex x y)
;;   (setf *current-position* (vector x y))
;;   (gl:end))

;; (defun move-to (x y)
;;   (setf *current-position* (vector x y)))

;; (defun reset-turtle ()
;;   (setf (aref *current-position* 0) 0)
;;   (setf (aref *current-position* 1) 0)
;;   (setf *direction* #(0 1 0)))

;; (defun draw-turtle ()
;;   (loop repeat 20 do  
;;     (forward 200)
;;     (rotate 170)))
 
;; (defun forward (draw-length)
;;   (let ((new-x (+ (aref *current-position* 0)
;; 		  (* (aref *direction* 0) draw-length)))
;; 	(new-y (+ (aref *current-position* 1)
;; 		  (* (aref *direction* 1) draw-length))))
;;     (line-to new-x new-y)))

;; (defun rotate (angle)
;;   (setf *direction* (z-rotation *direction* (* pi (/ angle 180.0)))))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "Turtle Graphics")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (init-ortho)
;; 	  (gl:line-width 5)
;; 	  (let ((p nil))
;; 	    (sdl2:with-event-loop (:method :poll)
;; 	      (:keydown (:keysym keysym)
;; 			(let ((scancode  (sdl2:scancode-value keysym))
;; 			      (sym       (sdl2:sym-value keysym))
;; 			      (mod-value (sdl2:mod-value keysym)))
;; 			  (declare (ignore sym mod-value))
;; 			  (cond
;; 			    ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit)))))
;; 	      (:idle ()
;; 		     (gl:clear :color-buffer-bit :depth-buffer-bit)
;; 		     (gl:matrix-mode :modelview)
;; 		     (gl:load-identity)
;; 		     (gl:begin :points)
;; 		     (gl:vertex 0 0)
;; 		     (gl:end)
;; 		     (reset-turtle)
;; 		     (draw-turtle)
;; 		     (sdl2:gl-swap-window screen))
;; 	      (:quit () t))))))))

;;LECTURE 23. LINDENMAYER SYSTEM
;; (defvar *screen-width*  800)
;; (defvar *screen-height* 800)
;; (defvar *ortho-left* -400)
;; (defvar *ortho-right* 400)
;; (defvar *ortho-top* -400)
;; (defvar *ortho-bottom* 400)
;; (defvar *current-position* #(0 0))
;; (defvar *direction* #(0 1 0))

;; (defvar *axiom* "F")
;; (defvar *rules* '(("F" . "F[+F]F")))
;; (defvar *draw-length* 10)
;; (defvar *angle* 90)
;; (defvar *stack* (make-array 5 :fill-pointer 0 :adjustable t))
;; (defvar *rule-run-number* 5)
;; (defvar *instructions* "")


;; (defun find-data (key-string rules)
;;   (cdr (assoc key-string rules :test #'equal)))

;; (defun replace-all (rules old-str new-str key-string)
;;   (str:replace-all old-str new-str (find-data key-string rules)))

;; (defun update-rules-generic (old-str new-str key-string)
;;   (setf (cdr (car *rules*)) (replace-all *rules* old-str new-str key-string)))

;; ;; updates global *rules* variable (destructive)
;; (defun run-rule (times)
;;   (loop repeat times do (update-rules-generic *axiom* "F[+F]F" "F"))
;;   (print "Rule")
;;   (print *rules*))

;; (defun map-value (current-min current-max new-min new-max value)
;;   (let ((current-range (- current-max current-min))
;; 	(new-range (- new-max new-min)))
;;     (+ new-min (* new-range (/ (- value current-min)
;; 			       current-range)))))

;; (defun x-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3)
;; 				:initial-contents
;; 				`((1 0 0)
;; 				  (0 ,(cos theta) ,(* -1 (sin theta)))
;; 				  (0 ,(sin theta) ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun y-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3)
;; 				:initial-contents
;; 				`((,(cos theta) 0 ,(sin theta))
;; 				  (0 1 0)
;; 				  (,(* -1 (sin theta)) 0 ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun z-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3)
;; 				:initial-contents
;; 				`((,(cos theta) ,(* -1 (sin theta)) 0)
;; 				  (,(sin theta) ,(cos theta) 0)
;; 				  (0 0 1)))))
;;     (lla:mm new-vector vector2)))

;; (defun init-ortho ()
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))

;; (defun line-to (x y)
;;   (gl:begin :line-strip)
;;   (gl:vertex (aref *current-position* 0) (aref *current-position* 1))
;;   (gl:vertex x y)
;;   (setf *current-position* (vector x y))
;;   (gl:end))

;; (defun move-to (x y)
;;   (setf *current-position* (vector x y)))

;; (defun reset-turtle ()
;;   (setf (aref *current-position* 0) 0)
;;   (setf (aref *current-position* 1) 0)
;;   (setf *direction* #(0 1 0)))

;; (defun draw-turtle ()
;;   (loop repeat 20 do  
;;     (forward 200)
;;     (rotate 170)))
 
;; (defun forward (draw-length)
;;   (let ((new-x (+ (aref *current-position* 0)
;; 		  (* (aref *direction* 0) draw-length)))
;; 	(new-y (+ (aref *current-position* 1)
;; 		  (* (aref *direction* 1) draw-length))))
;;     (line-to new-x new-y)))

;; (defun rotate (angle)
;;   (setf *direction* (z-rotation *direction* (* pi (/ angle 180.0)))))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "Turtle Graphics")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (init-ortho)
;; 	  (gl:line-width 5)
;; 	  (run-rule *rule-run-number*)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (gl:clear :color-buffer-bit :depth-buffer-bit)
;; 		   (gl:matrix-mode :modelview)
;; 		   (gl:load-identity)
;; 		   (gl:begin :points)
;; 		   (gl:vertex 0 0)
;; 		   (gl:end)
;; 		   (reset-turtle)
;; 		   (draw-turtle)
;; 		   (sdl2:gl-swap-window screen))
;; 	    (:quit () t)))))))

;;; SIMPLIFIED VERSION OF LECTURE 24. DRAWING AN L-SYSTEM.
;; (defvar *screen-width*  800)
;; (defvar *screen-height* 800)
;; (defvar *ortho-left* -400)
;; (defvar *ortho-right* 400)
;; (defvar *ortho-top* 0)
;; (defvar *ortho-bottom* 800)
;; (defvar *current-position* #(0 0))
;; (defvar *direction* #(0 1 0))

;; (defvar *instructions* "FF[+F][--FF][-F+F]")

;; (defvar *axiom* "F")
;; (defvar *rules* `(("F" . ,*instructions*)))
;; (defvar *draw-length* 10)
;; (defvar *angle* 25)
;; (defvar *stack* (make-array 5 :fill-pointer 0 :adjustable t))
;; (defvar *rule-run-number* 5)


;; (defun find-data (key-string rules)
;;   (cdr (assoc key-string rules :test #'equal)))

;; (defun replace-all (rules old-str new-str key-string)
;;   (str:replace-all old-str new-str (find-data key-string rules)))

;; (defun update-rules-generic (old-str new-str key-string)
;;   (setf (cdr (car *rules*)) (replace-all *rules* old-str new-str key-string)))

;; ;; updates global *rules* variable (destructive)
;; (defun run-rule (times)
;;   (loop repeat (- times 1) do (update-rules-generic *axiom* *instructions* *axiom*))
;;   (print "Rule")
;;   (print *rules*))

;; (defun map-value (current-min current-max new-min new-max value)
;;   (let ((current-range (- current-max current-min))
;; 	(new-range (- new-max new-min)))
;;     (+ new-min (* new-range (/ (- value current-min)
;; 			       current-range)))))

;; (defun x-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3)
;; 				:initial-contents
;; 				`((1 0 0)
;; 				  (0 ,(cos theta) ,(* -1 (sin theta)))
;; 				  (0 ,(sin theta) ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun y-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3)
;; 				:initial-contents
;; 				`((,(cos theta) 0 ,(sin theta))
;; 				  (0 1 0)
;; 				  (,(* -1 (sin theta)) 0 ,(cos theta))))))
;;     (lla:mm new-vector vector2)))

;; (defun z-rotation (vector2 theta)
;;   (let ((new-vector (make-array '(3 3)
;; 				:initial-contents
;; 				`((,(cos theta) ,(* -1 (sin theta)) 0)
;; 				  (,(sin theta) ,(cos theta) 0)
;; 				  (0 0 1)))))
;;     (lla:mm new-vector vector2)))

;; (defun init-ortho ()
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:ortho-2d *ortho-left* *ortho-right* *ortho-top* *ortho-bottom*))

;; (defun line-to (x y)
;;   (gl:begin :line-strip)
;;   (gl:vertex (aref *current-position* 0) (aref *current-position* 1))
;;   (gl:vertex x y)
;;   (setf *current-position* (vector x y))
;;   (gl:end))

;; (defun move-to (pos)
;;   (setf *current-position* (vector (aref pos 0) (aref pos 1))))

;; (defun reset-turtle ()
;;   (setf (aref *current-position* 0) 0)
;;   (setf (aref *current-position* 1) 0)
;;   (setf *direction* #(0 1 0)))

;; (defun do-draw-turtle (i)
;;   (cond ((equal i #\F) (forward *draw-length*))
;; 	((equal i #\+) (rotate *angle*))
;; 	((equal i #\-) (rotate (* -1 *angle*)))
;; 	((equal i #\[) (progn (push *direction* *stack*)
;; 			      (push *current-position* *stack*)))
;; 	((equal i #\]) (progn (move-to (pop *stack*))
;; 			      (setf *direction* (pop *stack*))))
;; 	(t (rotate 0))))

;; (defun draw-turtle ()
;;   (loop for i across (find-data "F" *rules*) do (do-draw-turtle i)))
 
;; (defun forward (draw-length)
;;   (let ((new-x (+ (aref *current-position* 0)
;; 		  (* (aref *direction* 0) draw-length)))
;; 	(new-y (+ (aref *current-position* 1)
;; 		  (* (aref *direction* 1) draw-length))))
;;     (line-to new-x new-y)))

;; (defun rotate (angle)
;;   (setf *direction* (z-rotation *direction* (* pi (/ angle 180.0)))))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "Turtle Graphics")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (init-ortho)
;; 	  (gl:line-width 1)
;; 	  (run-rule *rule-run-number*)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (gl:clear :color-buffer-bit :depth-buffer-bit)
;; 		   (gl:matrix-mode :modelview)
;; 		   (gl:load-identity)
;; 		   (gl:begin :points)
;; 		   (gl:vertex 0 0)
;; 		   (gl:end)
;; 		   (reset-turtle)
;; 		   (draw-turtle)
;; 		   (sdl2:gl-swap-window screen))
;; 	    (:quit () t)))))))

;;; LECTURE 25 and 26. I think we do not need more fractals.

;;; LECTURE 27. WORKING WITH MESHES
;; (defvar *screen-width*  1000)
;; (defvar *screen-height* 800)
;; (defvar *vertices* #((0.5 -0.5 0.5)
;; 		     (-0.5 -0.5 0.5)
;; 		     (0.5 0.5 0.5)
;; 		     (-0.5 0.5 0.5)
;; 		     (0.5 0.5 -0.5)
;; 		     (-0.5 0.5 -0.5)
;; 		     (0.5 -0.5 -0.5)
;; 		     (-0.5 -0.5 -0.5)
;; 		     (0.5 0.5 0.5)
;; 		     (-0.5 0.5 0.5)
;; 		     (0.5 0.5 -0.5)
;; 		     (-0.5 0.5 -0.5)
;; 		     (0.5 -0.5 -0.5)
;; 		     (0.5 -0.5 0.5)
;; 		     (-0.5 -0.5 0.5)
;; 		     (-0.5 -0.5 -0.5)
;; 		     (-0.5 -0.5 0.5)
;; 		     (-0.5 0.5 0.5)
;; 		     (-0.5 0.5 -0.5)
;; 		     (-0.5 -0.5 -0.5)
;; 		     (0.5 -0.5 -0.5)
;; 		     (0.5 0.5 -0.5)
;; 		     (0.5 0.5 0.5)
;; 		     (0.5 -0.5 0.5)))
;; (defvar *triangles* #(0 2 3 0 3 1 8 4 5 8 5 9 10 6 7 10 7 11 12 13 14
;; 		      12 14 15 16 17 18 16 18 19 20 21 22 20 22 23))
;; (defvar *background-color* '(0 0 0 1))
;; (defvar *drawing-color* '(1 1 1 1))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defclass mesh ()
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 6)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1)
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *mesh* (make-instance 'mesh))

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 100.0)
;;   (gl:matrix-mode :modelview)
;;   (gl:translate 0 0 -5)
;;   (gl:load-identity)
;;   (gl:viewport 0 0 *screen-width* *screen-height*)
;;   (gl:enable :depth-test)
;;   (gl:translate 0 0 -2))

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (gl:rotate 1 10 0 10)
;;   (gl:push-matrix)
;;   (draw *mesh*)
;;   (gl:pop-matrix))


;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   (sleep 0.100))
;; 	    (:quit () t)))))))

;;; LECTURES 28. CREATING A CUBE CLASS
;; (defvar *screen-width*  1000)
;; (defvar *screen-height* 800)
;; (defvar *background-color* '(0 0 0 1))
;; (defvar *drawing-color* '(1 1 1 1))

;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defclass mesh ()
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 6)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1)
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defclass cube (mesh)
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (0.5 -0.5 0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 24)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1 8 4 5 8 5 9 10 6 7 10 7 11 12 13 14
;; 		          12 14 15 16 17 18 16 18 19 20 21 22 20 22 23)
;; 	      :accessor triangles
;; 	      :type (simple-vector 36)
;; 	      :allocation :class)
;;    (draw-type :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *cube* (make-instance 'cube :draw-type :line-loop)) ;; :line-loop or :polygon

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 100.0)
;;   (gl:matrix-mode :modelview)
;;   (gl:translate 0 0 -5)
;;   (gl:load-identity)
;;   (gl:viewport 0 0 *screen-width* *screen-height*) 
;;   (gl:enable :depth-test)
;;   (gl:translate 0 0 -2))

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (gl:rotate 1 10 0 1)
;;   (gl:push-matrix)
;;   (draw *cube*)
;;   (gl:pop-matrix))


;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   (sleep 0.100))
;; 	    (:quit () t)))))))


;; ;;; LECTURE 29 and LECTURE 30
;; (defclass mesh ()
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 6)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1)
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defclass cube (mesh)
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (0.5 -0.5 0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 24)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1 8 4 5 8 5 9 10 6 7 10 7 11 12 13 14
;; 		          12 14 15 16 17 18 16 18 19 20 21 22 20 22 23)
;; 	      :accessor triangles
;; 	      :type (simple-vector 36)
;; 	      :allocation :class)
;;    (draw-type :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defclass load-mesh (mesh)
;;   ((vertices :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	     :initarg :vertices
;; 	     :accessor vertices
;; 	     :allocation :instance)
;;    (triangles :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	      :initarg :triangles
;; 	      :accessor triangles
;; 	      :allocation :instance)
;;    (filename :initarg :filename
;; 	     :accessor filename
;; 	     :type string
;; 	     :allocation :instance)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :type keyword
;; 	      :allocation :instance)))

;; (defmethod draw ((m load-mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defgeneric load-drawing (load-mesh))

;; (defmethod load-drawing ((m load-mesh))
;;   (with-open-file (stream (filename m))
;;     (do ((line (read-line stream nil)
;; 	       (read-line stream nil)))
;; 	((null line))

;;       (if (equal (str:substring 0 2 line)
;; 		 "v ")
;; 	  (multiple-value-bind (vx vy vz)
;; 	    (values (parse-float (second (str:words line)))
;; 	            (parse-float (third (str:words line))) 
;; 	            (parse-float (fourth (str:words line))))
;; 	    (vector-push-extend `(,vx ,vy ,vz)
;; 				(vertices m))))
      
;;       (if (equal (str:substring 0 2 line)
;; 		 "f ")
;; 	  (multiple-value-bind (t1 t2 t3)
;; 	      (multiple-value-bind (vx vy vz)
;; 		(values (parse-integer (first (str:split "/" (second (str:words line)))))
;; 		        (parse-integer (first (str:split "/" (third (str:words line))))) 
;; 		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
		
;; 		(values vx vy vz))
;; 	    ;; (vector-push-extend (make-array 5 :fill-pointer 0 :adjustable t) (vector-push-extend ...)
;; 	    ;; oburturlusu olan #(#()) verir.
;; 	    (vector-push-extend t1
;; 				(triangles m))
;; 	    (vector-push-extend t2
;; 				(triangles m))
;; 	    (vector-push-extend t3
;; 				(triangles m)))))))

;; (defmethod print-object ((obj load-mesh) stream)
;;   (print-unreadable-object (obj stream :type t)
;;     (with-accessors ((vertices vertices)
;; 		     (triangles triangles))
;; 	obj
;;       (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *cube* (make-instance 'cube :draw-type :line-loop)) ;; :line-loop or :polygon
;; (defvar *mesh* (make-instance 'load-mesh :filename "cube.obj"))

;; (load-drawing *mesh*)

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 100.0)
;;   (gl:matrix-mode :modelview)
;;   (gl:translate 0 0 -6)
;;   (gl:load-identity)
;;   (gl:viewport 0 0 *screen-width* *screen-height*) 
;;   (gl:enable :depth-test)
;;   (gl:translate 0 0 -3)) ;; change -3 for different values and check the result.

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (gl:rotate 1 10 0 1)
;;   (gl:push-matrix)
;;   ;; (draw *cube*) ;; LECTURE 29 the only diffference between Lec 29 and 30
;;   (draw *mesh*)    ;; LECTURE 30 the only diffference between Lec 29 and 30
;;   (gl:pop-matrix))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   (sleep 0.100))
;; 	    (:quit () t)))))))

;; ;;; LECTURE 30. BUGGY! try to directly import a mesh from blender.
;; (defvar *screen-width*  1000)
;; (defvar *screen-height* 800)
;; (defvar *background-color* '(0 0 0 1))
;; (defvar *drawing-color* '(1 1 1 1))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defclass mesh ()
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 6)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1)
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defclass cube (mesh)
;;   ((vertices :initform #((0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (-0.5 -0.5 0.5)
;; 			 (-0.5 0.5 0.5)
;; 			 (-0.5 0.5 -0.5)
;; 			 (-0.5 -0.5 -0.5)
;; 			 (0.5 -0.5 -0.5)
;; 			 (0.5 0.5 -0.5)
;; 			 (0.5 0.5 0.5)
;; 			 (0.5 -0.5 0.5))
;; 	     :accessor vertices
;; 	     :type (simple-vector 24)
;; 	     :allocation :class)
;;    (triangles :initform #(0 2 3 0 3 1 8 4 5 8 5 9 10 6 7 10 7 11 12 13 14
;; 		          12 14 15 16 17 18 16 18 19 20 21 22 20 22 23)
;; 	      :accessor triangles
;; 	      :type (simple-vector 36)
;; 	      :allocation :class)
;;    (draw-type :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defclass load-mesh (mesh)
;;   ((vertices :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	     :initarg :vertices
;; 	     :accessor vertices
;; 	     :allocation :instance)
;;    (triangles :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	      :initarg :triangles
;; 	      :accessor triangles
;; 	      :allocation :instance)
;;    (filename :initarg :filename
;; 	     :accessor filename
;; 	     :type string
;; 	     :allocation :instance)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :type keyword
;; 	      :allocation :instance)))

;; (defmethod draw ((m load-mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defgeneric load-drawing (load-mesh))

;; (defmethod load-drawing ((m load-mesh))
;;   (with-open-file (stream (filename m))
;;     (do ((line (read-line stream nil)
;; 	       (read-line stream nil)))
;; 	((null line))

;;       (if (equal (str:substring 0 2 line)
;; 		 "v ")
;; 	  (multiple-value-bind (vx vy vz)
;; 	    (values (parse-float (second (str:words line)))
;; 	            (parse-float (third (str:words line))) 
;; 	            (parse-float (fourth (str:words line))))
;; 	    (vector-push-extend `(,vx ,vy ,vz)
;; 				(vertices m))))
      
;;       (if (equal (str:substring 0 2 line)
;; 		 "f ")
;; 	  (multiple-value-bind (t1 t2 t3)
;; 	      (multiple-value-bind (vx vy vz)
;; 		(values (parse-integer (first (str:split "/" (second (str:words line)))))
;; 		        (parse-integer (first (str:split "/" (third (str:words line))))) 
;; 		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
		
;; 		(values vx vy vz))
;; 	    ;; (vector-push-extend (make-array 5 :fill-pointer 0 :adjustable t) (vector-push-extend ...)
;; 	    ;; oburturlusu olan #(#()) verir.
;; 	    (vector-push-extend t1
;; 				(triangles m))
;; 	    (vector-push-extend t2
;; 				(triangles m))
;; 	    (vector-push-extend t3
;; 				(triangles m)))))))

;; (defmethod print-object ((obj load-mesh) stream)
;;   (print-unreadable-object (obj stream :type t)
;;     (with-accessors ((vertices vertices)
;; 		     (triangles triangles))
;; 	obj
;;       (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; ;; (defvar *cube* (make-instance 'cube :draw-type :line-loop)) ;; :line-loop or :polygon
;; (defvar *mesh* (make-instance 'load-mesh :filename "granny.obj" :draw-type :line-loop))

;; (load-drawing *mesh*)

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 1000.0)
;;   (gl:matrix-mode :modelview)
;;   (gl:translate 0 0 -5)
;;   (gl:load-identity)
;;   (gl:viewport 0 0 *screen-width* *screen-height*) 
;;   (gl:enable :depth-test)
;;   (gl:translate 0 -100 -200)) ;; change x,y and z values -3 for different values and check the result.

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (gl:rotate 1 10 0 1)
;;   (gl:push-matrix)
;;   ;; (draw *cube*) ;; LECTURE 29 the only diffference between Lec 29 and 30
;;   (draw *mesh*)    ;; LECTURE 30 the only diffference between Lec 29 and 30
;;   (gl:pop-matrix))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   (sleep 0.100))
;; 	    (:quit () t)))))))


;; ;;;LECTURE 32. SETTING VIEWING TRANSFORMATIONS
;; (defvar *screen-width*  1000)
;; (defvar *screen-height* 800)
;; (defvar *background-color* '(0 0 0 1))
;; (defvar *drawing-color* '(1 1 1 1))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defclass mesh ()
;;   ((vertices ; we do not need initform when we were loading vertex data from the file.  
;;               :accessor vertices
;;               :type (simple-vector 6)
;;               :allocation :class)
;;    (triangles ; we do not need initform when we were loading vertex data from the file.   
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defclass load-mesh (mesh)
;;   ((vertices :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	     :initarg :vertices
;; 	     :accessor vertices
;; 	     :allocation :instance)
;;    (triangles :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	      :initarg :triangles
;; 	      :accessor triangles
;; 	      :allocation :instance)
;;    (filename :initarg :filename
;; 	     :accessor filename
;; 	     :type string
;; 	     :allocation :instance)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :type keyword
;; 	      :allocation :instance)))

;; (defmethod draw ((m load-mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defgeneric load-drawing (load-mesh))

;; (defmethod load-drawing ((m load-mesh))
;;   (with-open-file (stream (filename m))
;;     (do ((line (read-line stream nil)
;; 	       (read-line stream nil)))
;; 	((null line))
;;       (if (equal (str:substring 0 2 line) "v ")
;; 	  (multiple-value-bind (vx vy vz)
;; 	    (values (parse-float (second (str:words line)))
;; 	            (parse-float (third (str:words line))) 
;; 	            (parse-float (fourth (str:words line))))
;; 	    (vector-push-extend `(,vx ,vy ,vz)
;; 				(vertices m))))
;;       (if (equal (str:substring 0 2 line) "f ")
;; 	  (multiple-value-bind (t1 t2 t3)
;; 	      (multiple-value-bind (vx vy vz)
;; 		(values (parse-integer (first (str:split "/" (second (str:words line)))))
;; 		        (parse-integer (first (str:split "/" (third (str:words line))))) 
;; 		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
;; 		(values vx vy vz))
;; 	    (vector-push-extend t1 (triangles m))
;; 	    (vector-push-extend t2 (triangles m))
;; 	    (vector-push-extend t3 (triangles m)))))))

;; (defmethod print-object ((obj load-mesh) stream)
;;   (print-unreadable-object (obj stream :type t)
;;     (with-accessors ((vertices vertices)
;; 		     (triangles triangles))
;; 	obj
;;       (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *mesh* (make-instance 'load-mesh :filename "cube.obj" :draw-type :line-loop))

;; (load-drawing *mesh*)

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   ;; projection matrix setup
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 500.0)
;;   ;; modelview matrix setup
;;   (gl:matrix-mode :modelview)
;;   (gl:load-identity) ;; clears out old values that are in modelview matrix
;;   (gl:viewport 0 0 *screen-width* *screen-height*) 
;;   (gl:enable :depth-test))

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (gl:push-matrix)
;;   (gl:scale 0.5 0.5 0.5)
;;   (draw *mesh*)
;;   (gl:load-identity)
;;   (draw *mesh*)
;;   (gl:pop-matrix))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape)
;; 			   (sdl2:push-event :quit)))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   (sleep 0.100))
;; 	    (:quit () t)))))))

;; from now we will use cube.obj instead of teapot.obj because of a bug that i do not want deal with it.

;;; LECTURE 33. MOVING AND AIMING CAMERA
;; (defvar *screen-width*  1000)
;; (defvar *screen-height* 800)
;; (defvar *background-color* '(0 0 0 1))
;; (defvar *drawing-color* '(1 1 1 1))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defclass mesh ()
;;   ((vertices ; we do not need initform when we were loading vertex data from the file.  
;;               :accessor vertices
;;               :type (simple-vector 6)
;;               :allocation :class)
;;    (triangles ; we do not need initform when we were loading vertex data from the file.   
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defclass load-mesh (mesh)
;;   ((vertices :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	     :initarg :vertices
;; 	     :accessor vertices
;; 	     :allocation :instance)
;;    (triangles :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	      :initarg :triangles
;; 	      :accessor triangles
;; 	      :allocation :instance)
;;    (filename :initarg :filename
;; 	     :accessor filename
;; 	     :type string
;; 	     :allocation :instance)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :type keyword
;; 	      :allocation :instance)))

;; (defmethod draw ((m load-mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defgeneric load-drawing (load-mesh))

;; (defmethod load-drawing ((m load-mesh))
;;   (with-open-file (stream (filename m))
;;     (do ((line (read-line stream nil)
;; 	       (read-line stream nil)))
;; 	((null line))
;;       (if (equal (str:substring 0 2 line) "v ")
;; 	  (multiple-value-bind (vx vy vz)
;; 	    (values (parse-float (second (str:words line)))
;; 	            (parse-float (third (str:words line))) 
;; 	            (parse-float (fourth (str:words line))))
;; 	    (vector-push-extend `(,vx ,vy ,vz)
;; 				(vertices m))))
;;       (if (equal (str:substring 0 2 line) "f ")
;; 	  (multiple-value-bind (t1 t2 t3)
;; 	      (multiple-value-bind (vx vy vz)
;; 		(values (parse-integer (first (str:split "/" (second (str:words line)))))
;; 		        (parse-integer (first (str:split "/" (third (str:words line))))) 
;; 		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
;; 		(values vx vy vz))
;; 	    (vector-push-extend t1 (triangles m))
;; 	    (vector-push-extend t2 (triangles m))
;; 	    (vector-push-extend t3 (triangles m)))))))

;; (defmethod print-object ((obj load-mesh) stream)
;;   (print-unreadable-object (obj stream :type t)
;;     (with-accessors ((vertices vertices)
;; 		     (triangles triangles))
;; 	obj
;;       (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *mesh* (make-instance 'load-mesh :filename "cube.obj" :draw-type :line-loop))
;; ;; (defvar *mesh* (make-instance 'load-mesh :filename "teapot.obj" :draw-type :line-loop))
;; ;; (defvar *test*  (org.shirakumo.fraf.wavefront:parse #p"~/quicklisp/local-projects/ogl10/monkey.obj"))


;; (load-drawing *mesh*)

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 500.0))

;; (defvar *eye* (make-array 3 :initial-contents '(0 0 1)))

;; (defun init-camera ()  
;;   (gl:matrix-mode :modelview)
;;   (gl:load-identity)
;;   (gl:viewport 0 0 *screen-width* *screen-height*) 
;;   (gl:enable :depth-test)
;;   (glu:look-at (aref *eye* 0) (aref *eye* 1) (aref *eye* 2) 0 0 0 0 1 0))

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (init-camera) ;; bunun burda olmasi demek her frame yenilenmesi demek, acaba dogrumu?
;;   (gl:push-matrix)
;;   (gl:translate 0 0 -4)
;;   (draw *mesh*)
;;   ;; (gl:load-identity)
;;   (gl:scale 0.5 0.5 0.5)
;;   (gl:translate -7 -5 -5)
;;   (draw *mesh*)
;;   (gl:pop-matrix))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))
;; 			  ((sdl2:scancode= scancode :scancode-down) (incf (aref *eye* 2)))
;; 			  ((sdl2:scancode= scancode :scancode-up) (decf (aref *eye* 2)))
;; 			  ((sdl2:scancode= scancode :scancode-left) (decf (aref *eye* 0)))
;; 			  ((sdl2:scancode= scancode :scancode-right) (incf (aref *eye* 0)))
;; 			  ((sdl2:scancode= scancode :scancode-q) (incf (aref *eye* 1)))
;; 			  ((sdl2:scancode= scancode :scancode-w) (decf (aref *eye* 1))))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   ;; (sleep 0.100)
;; 		   )
;; 	    (:quit () t)))))))

;;; LECTURE 34. LIVE CAMERA MOVING (DOES NOT WORK PROPERLY)
;; (defvar *screen-width*  1000)
;; (defvar *screen-height* 800)
;; (defvar *background-color* '(0 0 0 1))
;; (defvar *drawing-color* '(1 1 1 1))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defclass mesh ()
;;   ((vertices ; we do not need initform when we were loading vertex data from the file.  
;;               :accessor vertices
;;               :type (simple-vector 6)
;;               :allocation :class)
;;    (triangles ; we do not need initform when we were loading vertex data from the file.   
;; 	      :accessor triangles
;; 	      :type (simple-vector 6)
;; 	      :allocation :class)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :accessor draw-type
;; 	      :type keyword
;; 	      :allocation :class)))

;; (defgeneric draw (mesh))

;; (defmethod draw ((m mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defclass load-mesh (mesh)
;;   ((vertices :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	     :initarg :vertices
;; 	     :accessor vertices
;; 	     :allocation :instance)
;;    (triangles :initform (make-array 5 :fill-pointer 0 :adjustable t)
;; 	      :initarg :triangles
;; 	      :accessor triangles
;; 	      :allocation :instance)
;;    (filename :initarg :filename
;; 	     :accessor filename
;; 	     :type string
;; 	     :allocation :instance)
;;    (draw-type :initform :line-loop
;; 	      :initarg :draw-type
;; 	      :type keyword
;; 	      :allocation :instance)))

;; (defmethod draw ((m load-mesh))
;;   (do ((i 0 (+ i 1)))
;;       ((> i (- (length (vertices m)) 3)) 'return-value)
;;     (gl:begin (draw-type m))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) i)))
;; 		(second (aref (vertices m) (aref (triangles m) i)))
;; 		(third  (aref (vertices m) (aref (triangles m) i))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 1))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 1)))))
;;     (gl:vertex  (first  (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(second (aref (vertices m) (aref (triangles m) (+ i 2))))
;; 		(third  (aref (vertices m) (aref (triangles m) (+ i 2)))))
;;     (gl:end)))

;; (defgeneric load-drawing (load-mesh))

;; (defmethod load-drawing ((m load-mesh))
;;   (with-open-file (stream (filename m))
;;     (do ((line (read-line stream nil)
;; 	       (read-line stream nil)))
;; 	((null line))
;;       (if (equal (str:substring 0 2 line) "v ")
;; 	  (multiple-value-bind (vx vy vz)
;; 	    (values (parse-float (second (str:words line)))
;; 	            (parse-float (third (str:words line))) 
;; 	            (parse-float (fourth (str:words line))))
;; 	    (vector-push-extend `(,vx ,vy ,vz)
;; 				(vertices m))))
;;       (if (equal (str:substring 0 2 line) "f ")
;; 	  (multiple-value-bind (t1 t2 t3)
;; 	      (multiple-value-bind (vx vy vz)
;; 		(values (parse-integer (first (str:split "/" (second (str:words line)))))
;; 		        (parse-integer (first (str:split "/" (third (str:words line))))) 
;; 		        (parse-integer (first (str:split "/" (fourth (str:words line))))))
;; 		(values vx vy vz))
;; 	    (vector-push-extend t1 (triangles m))
;; 	    (vector-push-extend t2 (triangles m))
;; 	    (vector-push-extend t3 (triangles m)))))))

;; (defmethod print-object ((obj load-mesh) stream)
;;   (print-unreadable-object (obj stream :type t)
;;     (with-accessors ((vertices vertices)
;; 		     (triangles triangles))
;; 	obj
;;       (format stream "~% TRIANGLES: ~a ~% VERTICES: ~a ~%" triangles vertices))))

;; (defvar *camera*)
;; (defclass camera ()
;;   ((eye     :initform (vector 0 0 0)
;; 	    :accessor eye)
;;    (up      :initform (vector 0 1 0)
;; 	    :accessor up)
;;    (right   :initform (vector 1 0 0)
;; 	    :accessor right)
;;    (forward :initform (vector 0 0 1)
;; 	    :accessor forward)
;;    (look    :accessor look)))

;; (defmethod initialize-instance :after ((obj camera) &key)
;;   (with-accessors ((eye eye) (forward forward) (look look)) obj
;;     (setf (look obj) (vector (+ (aref eye 0) (aref forward 0))
;; 			     (+ (aref eye 1) (aref forward 1))
;; 			     (+ (aref eye 2) (aref forward 2))))))

;; (defmethod update-data ((c camera) arg)
;;   (cond ((equal arg :down)  (progn (incf (aref (eye c) 0) (+ (aref (eye c) 0) (aref (forward c) 0)))
;; 				   (incf (aref (eye c) 1) (+ (aref (eye c) 1) (aref (forward c) 1)))
;; 				   (incf (aref (eye c) 2) (+ (aref (eye c) 2) (aref (forward c) 2)))))
;; 	((equal arg :up)    (progn (incf (aref (eye c) 0) (- (aref (eye c) 0) (aref (forward c) 0)))
;; 				   (incf (aref (eye c) 1) (- (aref (eye c) 1) (aref (forward c) 1)))
;; 				   (incf (aref (eye c) 2) (- (aref (eye c) 2) (aref (forward c) 2)))))
;; 	((equal arg :left)  (progn (incf (aref (eye c) 0) (+ (aref (eye c) 0) (aref (right c) 0)))
;; 				   (incf (aref (eye c) 1) (+ (aref (eye c) 1) (aref (right c) 1)))
;; 				   (incf (aref (eye c) 2) (+ (aref (eye c) 2) (aref (right c) 2)))))
;; 	((equal arg :right) (progn (decf (aref (eye c) 0) (+ (aref (eye c) 0) (aref (right c) 0)))
;; 				   (decf (aref (eye c) 1) (+ (aref (eye c) 1) (aref (right c) 1)))
;; 				   (decf (aref (eye c) 2) (+ (aref (eye c) 2) (aref (right c) 2))))))
  
;;   (setf (aref (look c) 0) (+ (aref (eye c) 0) (aref (forward c) 0)))
;;   (setf (aref (look c) 1) (+ (aref (eye c) 1) (aref (forward c) 1)))
;;   (setf (aref (look c) 2) (+ (aref (eye c) 2) (aref (forward c) 2))))

;; (defmethod update-camera ((c camera))  
;;   (glu:look-at (aref (eye c)  0) (aref (eye c)  1) (aref (eye c)  2)
;; 	       (aref (look c) 0) (aref (look c) 1) (aref (look c) 2)
;; 	       (aref (up c)   0) (aref (up c)   1) (aref (up c)   2)))

;; ;; -------------------------------- ENGINE/MESH -------------------------------------

;; (defvar *mesh* (make-instance 'load-mesh :filename "cube.obj" :draw-type :line-loop))
;; (defvar *camera* (make-instance 'camera))

;; (load-drawing *mesh*)

;; (defun initialize ()
;;   (gl:clear-color (first  *background-color*)
;; 		  (second *background-color*)
;; 		  (third  *background-color*)
;; 		  (fourth *background-color*))
;;   (gl:color (first  *drawing-color*)
;; 	    (second *drawing-color*)
;; 	    (third  *drawing-color*)
;; 	    (fourth *drawing-color*))
;;   (gl:matrix-mode :projection)
;;   (gl:load-identity)
;;   (glu:perspective 60 (/ *screen-width* *screen-height*) 0.1 1000.0))

;; (defun camera-init ()
;;   (gl:matrix-mode :modelview)
;;   (gl:load-identity)
;;   (gl:viewport 0 0 *screen-width* *screen-height*) 
;;   (gl:enable :depth-test)
;;   (update-camera *camera*))

;; (defun display ()
;;   (gl:clear :color-buffer-bit :depth-buffer-bit)
;;   (camera-init)
;;   (gl:push-matrix)
;;   (gl:translate 0 0 5)
;;   (draw *mesh*)
;;   (gl:pop-matrix))

;; (defun main ()
;;   (sdl2:with-init (:everything)
;;     (sdl2:gl-set-attr :doublebuffer 1)
;;     (sdl2:with-window (screen :w *screen-width* :h *screen-height*
;; 			      :flags '(:opengl)
;; 			      :title "OpenGL in Common Lisp")
;;       (sdl2:with-gl-context (gl-context screen)
;; 	(progn
;; 	  (initialize)
;; 	  (sdl2:with-event-loop (:method :poll)
;; 	    (:keydown (:keysym keysym)
;; 		      (let ((scancode  (sdl2:scancode-value keysym))
;; 			    (sym       (sdl2:sym-value keysym))
;; 			    (mod-value (sdl2:mod-value keysym)))
;; 			(declare (ignore sym mod-value))
;; 			(cond
;; 			  ((sdl2:scancode= scancode :scancode-escape) (sdl2:push-event :quit))
;; 			  ((sdl2:scancode= scancode :scancode-up)    (progn (update-data *camera* :up)))
;; 			  ((sdl2:scancode= scancode :scancode-down)  (progn (update-data *camera* :down)))
;; 			  ((sdl2:scancode= scancode :scancode-left)  (progn (update-data *camera* :left)))
;; 			  ((sdl2:scancode= scancode :scancode-right) (progn (update-data *camera* :right))))))
;; 	    (:idle ()
;; 		   (display)
;; 		   (sdl2:gl-swap-window screen)
;; 		   ;; (sleep 0.100)
;; 		   )
;; 	    (:quit () t)))))))
