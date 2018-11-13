(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rest)
  (map (lambda (x) (cons first x)) rest)
)

(define (zip pairs)
  (cond 
    ((null? pairs) (list nil nil))
    (else 
      (append (list (map (lambda (sub-list) (car sub-list)) pairs)) 
              (list (map (lambda (sub-list) (cadr sub-list)) pairs)))
  ))) 

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
    (define (with-index s index)
     (if (null? s)
      ()
      (cons (list index (car s)) (with-index (cdr s) (+ index 1)))
     ))
  (with-index s 0)
)
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (cond
    ((or (null? denoms) (< total 0)) nil)
    ((= 0 total) (cons nil nil))
    (else
      (append
        (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
        (list-change total (cdr denoms))
      )
    )
  )
)
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (list form params (map (lambda (x) (let-to-lambda x)) body))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons 
             (list 'lambda (car (zip values)) (car body)) (cadr (zip values)))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )))
