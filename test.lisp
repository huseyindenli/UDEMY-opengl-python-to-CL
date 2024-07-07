;; ----------------------------------------------------------------------------------

;; (defvar *axiom* "F")
;; (defvar *rules* '(("F" . "F[+F]F")))
;; (defvar *draw-length* 10)
;; (defvar *angle* 90)
;; (defvar *stack* (make-array 5 :fill-pointer 0 :adjustable t))
;; (defvar *rule-run-number* 5)
;; (defvar *instructions* "")
 
;; (defun run-rule (run-count)
;;   (declare (optimize debug))
;;   (setf *instructions* *axiom*) 
;;   (let ((old-system "")) 
;;     (loop repeat run-count do
;;       (setf old-system *instructions*) 
;;       (setf *instructions* "") 
;;       (loop for c from 0 upto (length old-system) do
;; 	(if (assoc (aref old-system c) *rules* :test #'string=) ; ERROR: (concatenate 'string *instructions* ("F" . "F[+F]F")) 
;; 	    (progn (break "1")                                            ; (assoc              #\F                    *rules* :test #'string=)
;; 		   (setf *instructions* (concatenate 'string *instructions* (assoc (aref (print old-system) (print c)) *rules* :test #'string=)))
;; 		   (break "2"))
;; 	    (setf *instructions* (concatenate 'string *instructions* (coerce (aref old-system c) 'string))))
;; 	(print "Rule")
;; 	(print *instructions*)))))

;; ----------------------------------------------------------------------------------
