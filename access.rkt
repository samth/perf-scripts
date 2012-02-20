#lang racket/base

(require ffi/unsafe)

(define access (get-ffi-obj "access" #f (_fun _string/utf-8 _int -> _int)))
(define F_OK 0)

(provide access F_OK)
