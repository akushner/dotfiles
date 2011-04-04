;;; init-battery.el --- initializations for battery.el

;; Copyright (C) 2007, 2008 Noah S. Friedman

;; Author: Noah Friedman <friedman@splode.com>
;; Maintainer: friedman@splode.com
;; Created: 2007-07-23

;; $Id: init-battery.el,v 1.2 2008/07/09 04:28:17 friedman Exp $

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

(require 'battery)
(require 'list-fns)


;;;;;;
;;; Defuns
;;;;;;

;; ----------
(defun battery-linux-fixup-time (time)
  (cond ((member (cdr time) '("0:00" "N/A" ""))
         (setcdr time ""))
        (time
         (setcdr time (concat " " (cdr time))))))

(defun battery-cpufreq ()
  "Return current cpu frequency, in Mhz."
  (let ((cf (first-matching 'file-readable-p
              "/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"
              "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq")))
    (when cf
      (with-temp-buffer
        (insert-file-contents cf)
        (buffer-substring 1 (- (point-max) 4))))))


;;;;;;
;;; Advice
;;;;;;

;; ----------
(defadvice battery-format (after sinit:ctof activate)
  "If \"%d\" is followed by \".F\" in FORMAT, convert Celsius to Fahrenheit."
  (save-match-data
    (when (string-match "\\([0-9]+\\).F" ad-return-value)
      (let* ((C (string-to-number (match-string 1 ad-return-value)))
             (F (number-to-string (round (+ (* 1.8 C) 32)))))
        (setq ad-return-value
              (replace-match F nil t ad-return-value 1))))))

;; ----------
(defadvice battery-linux-proc-acpi (after sinit:fixups activate)
  "Fix:
%t: When remaining battery time is N/A or 0:00, just make empty string.

New:
%F: cpu frequency, in MHz."
  (battery-linux-fixup-time (assq ?t ad-return-value))

  (let ((freq (battery-cpufreq)))
    (when freq
      (setq ad-return-value (cons (cons ?F freq) ad-return-value)))))

;; ----------
(defadvice battery-linux-proc-apm (after sinit:fixups activate)
  "Fix:
%t: When remaining battery time is N/A or 0:00, just make empty string.

New:
%F: cpu frequency, in MHz."
  (battery-linux-fixup-time (assq ?t ad-return-value))

  (let ((freq (battery-cpufreq)))
    (when freq
      (setq ad-return-value (cons (cons ?F freq) ad-return-value)))))


;;;;;;
;;; Miscellaneous stuff to do
;;;;;;

(let* ((d (format "%c" (condition-case nil
                           (decode-char 'ucs #xB0)
                         (error ?\260))))
       (f (assq battery-status-function
                `((battery-linux-proc-apm  . " [%b%p%%%t]")
                  (battery-linux-proc-acpi ,@(concat " [%b%p%%%t,%d" d "F]"))))))
  (when f
    (setq battery-mode-line-format (cdr f))
    (when (and (battery-cpufreq)
               (string-match "\\(\\]\\)" battery-mode-line-format))
      (setq battery-mode-line-format
            (replace-match ",%FMhz\\1" nil nil battery-mode-line-format))
      (setq battery-update-interval 10))))

(provide 'init-battery)

;;; init-battery.el ends here
