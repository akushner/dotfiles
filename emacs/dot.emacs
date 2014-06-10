;;
;; Aaron's startup
;;
;; Lot's of stuff grabb from the web
;;

(setq emacs-load-start-time (current-time))

(defconst win32p
    (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst cygwinp
    (eq system-type 'cygwin)
  "Are we running on a WinTel cygwin system?")

(defconst linuxp
    (or (eq system-type 'gnu/linux)
        (eq system-type 'linux))
  "Are we running on a GNU/Linux system?")

(defconst unixp
  (or linuxp
      (eq system-type 'usg-unix-v)
      (eq system-type 'berkeley-unix))
  "Are we running unix")

(defconst linux-x-p
    (and window-system linuxp)
  "Are we running under X on a GNU/Linux system?")

(defvar emacs-debug-loading nil)

(defmacro add-site-lisp-load-path (path)
  `(setq load-path (append (list (concat emacs-site-lisp-directory ,path)) load-path)))

(defmacro add-load-path (path)
  `(setq load-path (append (list ,path) load-path)))

(when emacs-debug-loading
  (defadvice load (before debug-log activate)
    (message "(Tip from Kai G): Now loading: %s" (ad-get-arg 0))))

(add-to-list 'load-path "~/etc/init/emacs/site-lisp/")
(add-to-list 'load-path "~/etc/init/emacs/init/")

;; (global-font-lock-mode t)

;; (require 'psvn)

;;;;  (load "init-printing")
;; (load "init-cperl")
;; (load "init-keybindings")

;;; Default Settings
(setq next-line-add-newlines       nil)
(setq track-eol                    nil)
(setq scroll-step                  1  )
(setq hscroll-step                 1  )
(setq make-backup-files            nil)
(line-number-mode                  1  )     ; line-numbers
(column-number-mode                1  )
(setq-default transient-mark-mode  t  )
(setq require-final-newline        t  )
(setq-default indent-tabs-mode     nil)
(setq default-tab-width            2  )
(setq visible-bell                 t  ) ; no beeping

(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))


;;recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)
(global-set-key [(f11)] 'recentf-open-files)


(define-key isearch-mode-map "\C-w" 'my-isearch-yank-word)
(defun my-isearch-yank-word ()
  (interactive)
  (if (= (length isearch-string) 0)
      (progn (forward-word 1)
             (backward-word 1)))
  (isearch-yank-word))


(when window-system
  ;; enable wheelmouse support by default
 (mwheel-install)
 ;; use extended compound-text coding for X clipboard
 ;;(set-selection-coding-system 'compound-text-with-extensions)
 ;;(set-background-color "grey")
 ;; (set-foreground-color "black")
 )

;; if you encounter a file with ^M or ... at the end of every line,
;; get rid of them by pressing [F12]
(global-set-key [f12]      'cut-ctrlM) ; cut all ^M.
(defun cut-ctrlM ()
  "Cut all visible ^M."
   (interactive)
   (beginning-of-buffer)
   (while (search-forward "\r" nil t)
     (replace-match "" nil t))
)

;; tramp - ange-ftp but with ssh
(require 'tramp)
(setq tramp-default-method "ssh")



(when (require 'time-date nil t)
  (message "Emacs startup time: %d seconds." (time-to-seconds (time-since emacs-load-start-time))))

(desktop-read)

(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)


(defun search-google ()
  "Prompt for a query in the minibuffer, launch the web browser and query google."
  (interactive)
  (let ((search (read-from-minibuffer "Google Search: ")))
    (browse-url (concat "http://www.google.com/search?q=" search))))


(set-scroll-bar-mode 'right)
(setq-default indent-tabs-mode nil)
(setq isearch-lazy-highlight-initial-delay 10)

