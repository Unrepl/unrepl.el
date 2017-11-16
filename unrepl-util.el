;;; unrepl-util.el ---  -*- lexical-binding: t; -*-
;;
;; Filename: unrepl-util.el
;; Description:
;; Author: Daniel Barreto
;; Maintainer:
;; Copyright (C) 2017 Daniel Barreto
;; Created: Thu Nov 16 01:09:49 2017 (+0100)
;; Version:
;; Package-Requires: ()
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'clojure-mode)


(defun unrepl-last-sexp (&optional bounds)
  "Return the sexp preceding the point.
If BOUNDS is non-nil, return a list of its starting and ending position
instead.

BORROWED FROM CIDER."
  (apply (if bounds #'list #'buffer-substring-no-properties)
         (save-excursion
           (clojure-backward-logical-sexp 1)
           (list (point)
                 (progn (clojure-forward-logical-sexp 1)
                        (skip-chars-forward "[:blank:]")
                        (when (looking-at-p "\n") (forward-char 1))
                        (point))))))


(defmacro comment (&rest _body)
  "A wannabe 'clojure-like' comment macro."
  nil)


(comment  ;; For debugging purposes.
 (defun unrepl-retry ()
   "Reload everything and connect again."
   (interactive)
   (load "/home/volrath/projects/oss/unrepl.el/unrepl-util.el")
   (load "/home/volrath/projects/oss/unrepl.el/unrepl-mode.el")
   (load "/home/volrath/projects/oss/unrepl.el/unrepl-project.el")
   (load "/home/volrath/projects/oss/unrepl.el/unrepl-loop.el")
   (load "/home/volrath/projects/oss/unrepl.el/unrepl-repl.el")
   (load "/home/volrath/projects/oss/unrepl.el/unrepl.el")
   (unrepl-project-quit '127.0.0.1:5555)
   (unrepl-connect-to "localhost" 5555))
 (global-set-key (kbd "C-c C-y") #'unrepl-retry)
 )


(provide 'unrepl-util)

;;; unrepl-util.el ends here
