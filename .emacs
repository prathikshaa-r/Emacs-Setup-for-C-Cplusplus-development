(package-initialize)

(require 'git)

;; Uncomment this next line if you want line numbers on the left side
(global-linum-mode 1)

(global-set-key "\C-c\C-v" 'compile)
(setq line-number-mode t)
(setq column-number-mode t)
(display-time)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(show-paren-mode)


(global-set-key "\C-x\C-g" 'goto-line)


; Automatically set compilation mode to
; move to an error when you move the point over it
(add-hook 'compilation-mode-hook
 (lambda () 
   (progn
     (next-error-follow-minor-mode))))

;Automatically go to the first error
(setq compilation-auto-jump-to-first-error t)
(defun set-window-undedicated-p (window flag)
  "Never set window dedicated."
  flag)

(advice-add 'set-window-dedicated-p :override #'set-window-undedicated-p)
(require 'company)
(require 'company-rtags)
(global-company-mode)
(require 'clang-format)
(global-set-key [C-M-tab] 'clang-format-region)
(add-hook 'c-mode-common-hook
          (function (lambda ()
                    (add-hook 'write-contents-functions
                              (lambda() (progn (clang-format-buffer) nil))))))

(add-hook 'cpp-mode-common-hook
          (function (lambda ()
                      (add-hook 'write-contents-functions
                                (lambda() (progn (clang-format-buffer) nil))))))

(add-to-list 'company-backends 'company-c-headers)
(require 'flycheck)
(global-flycheck-mode)
(flycheck-popup-tip-mode)
(defun colorize-grade-txt ()
  "Make a grade.txt file show colors, then set read only."
  (interactive)
  (if (or (string= (buffer-name) "grade.txt")
          (string-prefix-p (buffer-name) "grade.txt<"))
      (progn (let ((inhibit-read-only t))
               (ansi-color-apply-on-region (point-min) (point-max)))
             (set-buffer-modified-p nil)
             (read-only-mode t))))

(add-hook 'find-file-hook 'colorize-grade-txt)
(add-hook 'gud-mode-hook (lambda() (company-mode 0)))
