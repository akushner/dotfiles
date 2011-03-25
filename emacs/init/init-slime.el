;;==================================================================
;;
;; Slime Setup
;;

(add-to-list 'load-path "/u02/home_nfs/akushner/build/slime")
(require 'slime)
(slime-setup) 	

(setq inferior-lisp-program "/usr/bin/sbcl"
     lisp-indent-function 'common-lisp-indent-function
     slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

;; (setq inferior-lisp-program "/usr/bin/clisp"
;;       lisp-indent-function 'common-lisp-indent-function
;;       slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

;; (require 'mic-paren)
;; (paren-activate)
;; (setf paren-priority 'close)
;; (define-key slime-mode-map (kbd "(") 'insert-parentheses)
;; (define-key slime-mode-map (kbd ")") 'mb:move-past-close)
;; (define-key slime-mode-map (kbd "RET") 'newline-and-indent)
;; (define-key slime-mode-map (kbd "<return>") 'newline-and-indent)
;; (defun mb:move-past-close ()
;;   "Move past next `)' and ensure just one space after it."
;;   (interactive)
;;   (delete-horizontal-space)
;;   (up-list))

(define-key slime-mode-map (kbd "C-h") 'backward-sexp)
(define-key slime-mode-map (kbd "C-t") 'transpose-sexps)
(define-key slime-mode-map (kbd "C-M-t") 'transpose-chars)
(define-key slime-mode-map (kbd "C-n") 'forward-sexp)
(define-key slime-mode-map (kbd "C-k") 'kill-sexp)
(define-key slime-mode-map (kbd "C-M-k") 'kill-line)
(define-key global-map (kbd "<f12>") 'slime-selector)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
