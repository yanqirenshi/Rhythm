# Rhythm

Simple Metronome

## Usage

```lisp
CL-USER> (in-package :rhythm)
#<PACKAGE "RHYTHM">
RHYTHM> (defvar *heart*
          (make-instance 'heart
                         :beat #'(lambda () (print "hert beat"))))
*HEART*
RHYTHM> (start *heart*)

#<SB-THREAD:THREAD "Tick!!!_#<HEART {101262ED43}>" RUNNING {1012A3CCF3}>
RHYTHM> (core *heart*)
#<SB-THREAD:THREAD "Tick!!!_#<HEART {101262ED43}>" RUNNING {1012A3CCF3}>
RHYTHM> (stop *heart*)
0
```

## Installation

```lisp
(ql:quickload :rhythm)
```
