

                                                             ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
							     ;; SECTION 3: BASIC GRAPHICS PRIMITIVES ;;
							     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;; ;;; Lecture 14. Drawing Lines Part 1												      ;;
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
