# Rhythm

Simple Metronome

<img src="https://github.com/yanqirenshi/rhythm/raw/master/assets/heart.svg?sanitize=true" alt="Image" title="svg" style="max-width:88px;">

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

## Symbols

### Class: __heart__

Tick the beat.

### Generic Function: __life-p__

Syntax: __life-p__ _heart_

Return heart status.

### Generic Function: __tune__

Syntax: __tune__ _heart bpm_

Change heart status.

| Status | bpm: before | bpm: after |
|--------|-------------|------------|
| Start  | = 0         | > 0        |
| Change | > 0         | > 0        |
| Stop   | > 0         | = 0        |

## Dependencies

- [bordeaux-threads](https://github.com/sionescu/bordeaux-threads)

## Author

+ Satoshi Iwasaki (yanqirenshi@gmail.com)

# Copyright

Copyright (c) 2018 Satoshi Iwasaki (yanqirenshi@gmail.com)

# License

LLGPL
