#lang racket/base

(require "access.rkt"
         (for-syntax "access.rkt" unstable/syntax racket/base))

(provide log-printing log-printing/stx)

(define-for-syntax log-printing? #t)

(define-syntax (log-printing stx)
  (if log-printing?                
      (syntax-case stx ()
        [(_ fmt args ...)
         #`(begin
	    (let ([str (apply format 
			      (string-append "MARK: drracket: ~a " fmt) 
			      #,(path->string (syntax-source-file-name stx))
			      (list args ...))]) 
	      (access str F_OK)))])
	#'(void)))

(define-syntax (log-printing/stx stx)
  (if log-printing?                
      (syntax-case stx ()
        [(_ fmt args ...)
         #`(begin-for-syntax
	    (let ([str (apply format 
			      (string-append "MARK: drracket: ~a "
					     #,(datum->syntax
						#'here (syntax-e #'fmt)))
			      #,(path->string (syntax-source-file-name stx))
			      (list args ...))]) 
	      (access str F_OK)))])
	#'(void)))

(log-printing "Loaded logger")
