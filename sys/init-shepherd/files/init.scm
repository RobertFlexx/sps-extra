;; SPS PID 1 config for GNU Shepherd.
(use-modules (ice-9 ftw)
             (shepherd service))

(define (directory? path)
  (and (file-exists? path)
       (eq? 'directory (stat:type (stat path)))))

(define (scm-name? name)
  (and (string-suffix? ".scm" name)
       (not (string-prefix? "." name))))

(define (name->symbol name)
  (string->symbol (substring name 0 (- (string-length name) 4))))

(define (load-service-dir dir)
  (when (directory? dir)
    (for-each
     (lambda (name)
       (when (scm-name? name)
         (primitive-load (string-append dir "/" name))))
     (or (scandir dir) '()))))

(define agetty-tty1
  (service '(agetty-tty1)
           #:documentation "getty on tty1"
           #:start (make-forkexec-constructor
                    '("/sbin/agetty" "--noclear" "tty1" "linux"))
           #:stop (make-kill-destructor)
           #:respawn? #t))

(define agetty-tty2
  (service '(agetty-tty2)
           #:documentation "getty on tty2"
           #:start (make-forkexec-constructor
                    '("/sbin/agetty" "tty2" "linux"))
           #:stop (make-kill-destructor)
           #:respawn? #t))

(define agetty-ttyS0
  (service '(agetty-ttyS0)
           #:documentation "serial getty"
           #:start (make-forkexec-constructor
                    '("/sbin/agetty" "-L" "115200" "ttyS0" "vt100"))
           #:stop (make-kill-destructor)
           #:respawn? #t))

(register-services (list agetty-tty1 agetty-tty2 agetty-ttyS0))
(load-service-dir "/etc/shepherd.d")
(start-in-the-background '(agetty-tty1 agetty-tty2 agetty-ttyS0))

(let ((dir "/etc/shepherd.d"))
  (when (directory? dir)
    (for-each
     (lambda (name)
       (when (scm-name? name)
         (catch #t
           (lambda ()
             (start-in-the-background (list (name->symbol name))))
           (lambda args #f))))
     (or (scandir dir) '()))))
