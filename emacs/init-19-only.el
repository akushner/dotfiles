;;; init-19-only.el --- startup for emacs version 19.x only

;; Copyright (C) 2007 Noah S. Friedman

;; Author: Noah Friedman <friedman@splode.com>
;; Maintainer: friedman@splode.com

;; $Id: init-19-only.el,v 1.1 2007/08/09 07:32:48 friedman Exp $

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 51 Franklin Street, Fifth Floor; Boston, MA 02110-1301, USA.

;;; Commentary:
;;; Code:

(require 'init)
(require 'init-19)
(require 'frame-fns)

;;;;;;
;;; Variables
;;;;;;

;; Emacs 20 has this already, and various recent packages want it.
(defvar temporary-file-directory
  (file-name-as-directory
   (cond ((memq system-type '(ms-dos windows-nt))
	  (or (getenv "TEMP") (getenv "TMPDIR") (getenv "TMP") "c:/temp"))
	 ((or (getenv "TMPDIR") "/tmp"))))
  "The directory for writing temporary files.")

;;;;;;
;;; Macros
;;;;;;

;; ----------
;; Needed for Emacs 19.34 and earlier, and XEmacs 19.14 and earlier.
;; This doesn't implement any customs support, but at least it makes modern
;; packages loadable in those older versions.
(init-eval-and-compile-unless (featurep 'custom)
  (load "custom" t)
  (load "cust-stub" t)
  (unless (fboundp 'defcustom)
    (defmacro defgroup (&rest args) nil)
    (defmacro defcustom (var value doc &rest args)
      (list 'defvar var value doc))))

;;;;;;
;;; Defuns
;;;;;;

;; ----------
;; Emacs 19 didn't have these; Emacs 20 and later do.
(mapc (lambda (fn)
        (unless (fboundp fn)
          (fset fn (make-general-car-cdr fn))))
  '(cadr cddr))

;;;;;;
;;; Miscellaneous stuff to do
;;;;;;

(when (require-soft 'iso-syntax)
  (standard-display-european 1)
  (disptable-insert-w32/palmos-8bit-glyphs standard-display-table))

(for-frame-type (x) use-terminus-font
  (when (x-list-fonts "-*-terminus-medium-r-normal--14-140-72-72-*-80-iso8859-1")
    (setq make-large-simple-frame-fontset 'terminus)))

(provide 'init-19-only)

;;; init-19-only.el ends here.
