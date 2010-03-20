;; based on org-export-visible org-exp.el
(defun org-test-export-visible ()
  "Create a copy of the visible part of the current buffer."
  (let* ((buffer (get-buffer-create "*Org Test Export Visible*"))
	 s)
    (with-current-buffer buffer (erase-buffer))
    (save-excursion
      (setq s (goto-char (point-min)))
      (while (not (= (point) (point-max)))
	(goto-char (org-find-invisible))
	(append-to-buffer buffer s (point))
	(setq s (goto-char (org-find-visible))))
      (goto-char (point-min))
      (set-buffer buffer))))

;; taken from org-exp.el
(defun org-test-find-visible ()
  (let ((s (point)))
    (while (and (not (= (point-max) (setq s (next-overlay-change s))))
		(get-char-property s 'invisible)))
    s))
(defun org-test-find-invisible ()
  (let ((s (point)))
    (while (and (not (= (point-max) (setq s (next-overlay-change s))))
		(not (get-char-property s 'invisible))))
    s))


;; initialize sample setup
(add-to-list 'load-path ".")
;; adjust this to the actual org-mode installation intended to be tested
(add-to-list 'load-path "~/.emacs.d/lisp/org-mode/")
(load "init.el")

;; open example input file
(find-file "input.org")

;; work on it
; fixme: execute and catch all errors
(load "actions.el")

;; save
(write-file "../results/output.org")

;; capture visible state of buffer to file
(org-test-export-visible)
(switch-to-buffer "*Org Test Export Visible*")
(write-file "../results/visual.txt")

;; exit
(kill-emacs)
