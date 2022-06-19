## Smart buffer switch extension functions for Emacs

### Getting Started 
```
git clone https://github.com/slamko/smart-swith-buffer.git
```
In your emacs config:
```
(add-to-list 'load-path "*cloned repo path*")
(require 'smart-buffer-switch)
```
---
This package was created to provide some helper functions that may simplify switching between Emacs buffers when multiple projects with many files and third party applications opened inside Emacs.

#### Main features include:
- ```switch-to-next/prev-file-buffer``` - Switch to the buffer associated with a file.
- ```switch-to-next/prev-user-buffer``` - Switch to the buffer created by the user ignoring Emacs-system buffers such as Message, Log, etc.
- ```switch-to-scratch-buffer```        - Switch to scratch buffer from any other. 
- ```switch-to-next/prev-project-buffer``` - Switch to the buffer associated with a file that lives within the current working directory tree.
- ```switch-to-next/prev-dir-buffer``` - Switch to the buffer with Dired opened.
- ```switch-to-last-buffer``` - Switch to your previous active buffer.

#### Also you may want to consider using ```keybindings.el``` as a template for ke bindings configuration for this package.
