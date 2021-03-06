#lang racket/base

; Simple wrapper for ios-compile.ss
;
; build me with:
; $ raco exe ios2flowlog.ss
;
; example for how to run on file IOS/talk-natfw.txt:
; $ ios2flowlog --path IOS talk-natfw.txt

(require racket/cmdline)
(require "ios-compile.ss")

(define path ".")
(define connfilename #f)
(define default-permit #f)

(command-line
 #:program "ios2flowlog"
 #:once-each
 ("--default-permit" "Use a default permit ACL"
                     (set! default-permit #t))
 ("--default-deny" "Use a default deny ACL [default]"
                   (set! default-permit #f))
 ("--path" input "Directory path to IOS files [default: .]"
           (set! path input))
 ("--conn" input "Name of file (in --path) with L2 connections spec"
           (set! connfilename input))
 #:args files
 (when (> (length files) 0)
     (compile-configurations path files default-permit connfilename)))
