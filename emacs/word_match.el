;; This hack adds a function isearch-at-point, which
;; initiates isearch using the text in the region or the word-at-point.

(load-library "thingatpt")

;; Need this for support
(defun push-isearch-string (isearch-string)
  "Push the supplied string onto isearch's search-ring.
Cribbed shamelessly from isearch.el."
  (if (or (null search-ring)
          (not (string= isearch-string (car search-ring))))
      (progn
        (setq search-ring (cons isearch-string search-ring))
        (if (> (length search-ring) search-ring-max)
            (setcdr (nthcdr (1- search-ring-max) search-ring) nil)))))

(defun isearch-at-point ()
  "Initiate isearch, using text near point.  If the mark is active,
the region is the search string, otherwise the word under the cursor
is used."
  (interactive)
  ;; Grab the word-at-point, or if that fails, assume point is
  ;; immediately following word and try again one character
  ;; earlier.
  (push-isearch-string
   (if (and transient-mark-mode mark-active)
       (buffer-substring (point) (mark))
     (or (thing-at-point 'word)
         (save-excursion
           (backward-char)
           (thing-at-point 'word)))))
  (call-interactively 'isearch-forward))

(defun isearch-at-point-hook ()
  ;; Support hook that detects that we arrived via isearch-at-point,
  ;; and immediately initiates isearch-repeat-forward
  (if (eq this-command 'isearch-at-point)
      (isearch-repeat-forward)))

(add-hook 'isearch-mode-hook 'isearch-at-point-hook)

;; Put it on your favorite key...
(global-set-key [f9] 'isearch-at-point) 
