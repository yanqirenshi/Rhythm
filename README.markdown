# Rhythm

Simple Metronome

[](https://github.com/yanqirenshi/rhythm/blob/master/assets/heart.jpeg)
[](https://github.com/yanqirenshi/rhythm/blob/master/assets/heart.png)
[](https://github.com/yanqirenshi/rhythm/blob/master/assets/heart.svg)

## Usage

```lisp
CL-USER> (in-package :rhythm)
#<PACKAGE "RHYTHM">
RHYTHM>
(defvar *heart*
  (make-instance 'heart
                 :name "my-heart"
                 :beat #'(lambda (heart times)
                           (format t "~a, ~a" heart times))))

*HEART*
RHYTHM> (tune *heart* 1)
#<HEART {100C5FF343}>
RHYTHM> (life-p *heart*)
T
RHYTHM> (core *heart*)
#<SB-THREAD:THREAD "my-heart, #<HEART {100C5FF343}>" RUNNING {100C621323}>
RHYTHM> (tune *heart* 0)
#<HEART {100C5FF343}>
RHYTHM> (life-p *heart*)
NIL
RHYTHM> (core *heart*)
#<SB-THREAD:THREAD "my-heart, #<HEART {100C5FF343}>" FINISHED values: #<HEART {100C5FF343}> {100C621323}>o
```

## Installation

```lisp
(ql:quickload :rhythm)
```
