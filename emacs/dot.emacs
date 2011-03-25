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

(defconst xemacsp (featurep 'xemacs)
  "Are we running XEmacs?")

(defconst emacs>=21p (and (not xemacsp) (or (= emacs-major-version 21) (= emacs-major-version 22)))
  "Are we running GNU Emacs 21 or above?")

(defvar emacs-debug-loading nil)

(defmacro add-site-lisp-load-path (path)
  `(setq load-path (append (list (concat emacs-site-lisp-directory ,path)) load-path)))

(defmacro add-load-path (path)
  `(setq load-path (append (list ,path) load-path)))

(when emacs-debug-loading
  (defadvice load (before debug-log activate)
    (message "(Tip from Kai G): Now loading: %s" (ad-get-arg 0))))

;; try to find the site-lisp directory in /opt/site-lisp
;; (condition-case nil
;;     (find-library-name "xsteve-functions")
;;   (error
;;    (when (file-exists-p "/opt/site-lisp/xsteve/xsteve-functions.el")
;;      (setq emacs-site-lisp-directory "/opt/site-lisp/")
;;      (add-load-path emacs-site-lisp-directory))))

(add-to-list 'load-path "~/etc/init/emacs/site-lisp/")
(add-to-list 'load-path "~/etc/init/emacs/init/")

(global-font-lock-mode t)

(require 'psvn)

(load "init-printing")
(load "init-cperl")
(load "init-keybindings")
(load "init-slime")

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


;; mic-paren stuff
(when (or (string-match "XEmacs\\|Lucid" emacs-version) window-system)
  (require 'mic-paren)                  ; loading
  (paren-activate)                      ; activating
      ;;; set here any of the customizable variables of mic-paren, e.g.:
      ;;; ...
  )

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(font-lock-maximum-decoration t)
 '(save-place t nil (saveplace))
 '(toolbar-visible-p nil)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(default ((t (:size "12pt" :family "Fixed")))))

(custom-set-faces
 '(default ((t (:size "12pt" :family "Fixed"))) t))

(when (or (string-match "XEmacs\\|Lucid" emacs-version) window-system)
  (require 'mic-paren) ; loading
  (paren-activate)     ; activating
     ;;; set here any of the customizable variables of mic-paren, e.g.:
     ;;; ...
  )


;;; Window System specific code
(cond (window-system
       ;; use some nicer colors for font-lock mode
       ;=(set-face-foreground 'font-lock-comment-face "gray50")
       ;=(set-face-foreground 'font-lock-string-face "green4")

       (unless xemacsp (global-font-lock-mode t))
       (setq font-lock-maximum-decoration t )
       (setq lazy-lock-defer-on-scrolling t)
       (if emacs>=21p
           (progn
             (setq font-lock-support-mode 'jit-lock-mode)
             (setq jit-lock-stealth-time 16)
             (setq jit-lock-stealth-nice 0.5)
             (setq font-lock-multiline t))
         (setq font-lock-support-mode 'lazy-lock-mode))
       ;(setq lazy-lock-defer-contextually t)
       ;(setq lazy-lock-defer-time 0)

       ;(set-background-color "old lace")
       ;(set-background-color "white")

       ;select a font interactive:
       ;(insert (concat "\n(set-default-font " (prin1-to-string (w32-select-font)) ")\n"))

       ;Courier new 10
       ;(set-default-font "-*-Courier New-normal-r-*-*-13-97-*-*-c-*-*-ansi-")

       ;Courier new 9
       ;(set-default-font "-*-Courier New-normal-r-*-*-12-90-*-*-c-*-*-ansi-")

       ;; Function Menu
       ;;(load "func-menu")    ; load function menu
       ;;(define-key global-map [S-down-mouse-3] 'function-menu)

       ;; match Parantheses
       (require 'paren)

;;       (require 'stig-paren) ;better than paren for lisp code

       (show-paren-mode)
       ;;(setq show-paren-style 'expression)
       (setq show-paren-style 'parenthesis)

       ;highlighting during i-search
       ;;(setq search-highlight t)
       (setq search-highlight 'nil)
       
       ;highlight during query
       ;;(setq query-replace-highlight t)
       ;;(setq query-replace-lazy-highlight t)

       ; use a bar cursor
       (add-to-list 'default-frame-alist '(cursor-type . bar))
       (add-to-list 'default-frame-alist '(cursor-type bar . 3))

       (require 'mouse-copy)
       (global-set-key [M-down-mouse-1] 'mouse-drag-secondary-pasting)
       (global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)
       ))

(global-font-lock-mode t)


(require 'filecache)

;; Desktop
(desktop-load-default)
;(load "desktop")
;(unless emacs>=21p
;(require 'desktop-menu)
;;(setq desktop-enable t)
(setq desktop-save 'if-exists)
;;(desktop-save-mode 1)
;(desktop-load-default)
;(desktop-read)
  ;(setq desktop-files-not-to-save "\\(^/[^/:]*:\\|\\.bbdb\\|\\*Group\\*\\|\\*Compile-Log\\*\\)")
  ;(setq desktop-files-not-to-save "\\(^/[^/:]*:\\|\\.bbdb\\)")
  ;(setq desktop-modes-not-to-save '(Info-mode)))

(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

;; Add proper semantic/ecb support for their minor modes
(setq desktop-minor-mode-table
      (append desktop-minor-mode-table
              '((ecb-minor-mode nil)
                (semantic-show-unmatched-syntax-mode nil)
                (semantic-stickyfunc-mode nil)
                (senator-minor-mode nil)
                (semantic-idle-scheduler-mode nil))))


(when (require 'time-date nil t)
  (message "Emacs startup time: %d seconds." (time-to-seconds (time-since emacs-load-start-time))))

(desktop-read)

(autoload 'woman "woman"
  "Decode and browse a UN*X man page." t)
(autoload 'woman-find-file "woman"
  "Find, decode and browse a specific UN*X man-page file." t)


;;;;; sql ;;;;;
;; (autoload 'sql-oracle "sql" "Interactive SQL mode." t)
;; (add-hook 'sql-mode-hook 'turn-on-font-lock)
;; (add-to-list 'auto-mode-alist '("\\.sql\\'" . sql-mode))
;; ; Add sql-indent for better indentation control.
;; (eval-after-load "sql"
;; 								   (progn
;; 										     (load-library "sql-indent")
;; 												     (setq sql-indent-offset 4)))
;; (setq sql-electric-stuff (quote semicolon))
;; (setq sql-indent-offset 4)
;; (setq sql-indent-offset 4)


;; added 23MAR2006
(eval-after-load "dabbrev" '(defalias 'dabbrev-expand 'hippie-expand))


(defun search-google ()
  "Prompt for a query in the minibuffer, launch the web browser and query google."
  (interactive)
  (let ((search (read-from-minibuffer "Google Search: ")))
    (browse-url (concat "http://www.google.com/search?q=" search))))


(set-scroll-bar-mode 'right)
(setq-default indent-tabs-mode nil)
(setq isearch-lazy-highlight-initial-delay 10)

