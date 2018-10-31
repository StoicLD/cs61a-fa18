(define (longest-increasing-subsequence lst)
  (define (lis-reversed lst current)
    (cond ((null? lst) current)
      (else (define a (lis-reversed (cdr lst) current))
            (define b (if (or (null? current)
                              (> (car lst) (car current)))
                        (lis-reversed (cdr lst) (cons (car lst) current))
                        nil))
            (if (> (length a) (length b)) a b)
        )
    ))
  (reverse (lis-reversed lst nil))
)