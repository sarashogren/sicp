;; C - Ctrl
;; M - Alt
;; S - Shift

;; i - insert mode
;; esc - command mode
;; hjkl - arrow keys
;; :w - save
;; x - delete
;; u - undo

;; C-) expand ->
;; C-( expand <-
;; C-] detract ->
;; C-[ detract <-

;; C-M-x - run top level form
;; C-x C-e - run previous form

;; C-w hjkl move windows
;; C-x 1 remove all other windows

;; C-g - cancel

;; comment...

(+ 147 349)
;; => 486
(- 1000 334)
;; => 666
(* 5 99)
;; => 495
(/ 10 5)
;; => 2
(+ 2.7 10)
;; => 12.7

(+ (* 3 5) (- 10 6))
;; => 19

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))
;; => 57
;; Also can write as:

(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))
;; => still results in 57

(define size 2)
;; define causes "2" to be associated with "size"
size
;; => 2
(* 5 size)
;; => 10

(define pi 3.14)
(define radius 10)
(define steve 28)
(define sara 26)
(+ steve sara)

;; procedure definitions:
(define (square x) (* x x))
;; To    square something multiply it by itself
;; This is a compound procedure: name is square
;; definition: (define (<name> <formal parameters>) <body>)
;; name is a symbol to be associated with the procedure definition in the text.
;; formal parameters are names used in the body of the procedure to refer to the 1corresponding arguments of the procedure
;; body is an expression
(square 21)
;; => 441
(square (+ 2 5))
;; => 49
;; we defined square as x, we need to give x a value in (square (+ 2 5) thus the expression + 2 5 is our x
(square (square 3))
;; 81
(define (sum-of-squares x y)
  (+ (square x) (square y)))
(sum-of-squares 3 4)
;; => 25

(define (f a)
  (sum-of-squares (+ 1 a) (* a 2)))
(f 5)

;; start of 1.1.5 

;;normal-order evaluation: fully expands the arguments and then reduces them
;;applicative-order evaluation: evaluate arguments then apply.
;; applicative evals more efficient. for the most part right now...applicative and normal evals produce same values.

;; chapter 1.1.6

;;case analysis: cond ... conditional

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (-x))))
;; general form:
;; (cond (<p1> <e1>)
;;       (<p2> <e2>)
;;    ...(<pn> <en>))


;; parenthesized pairs of expressions following the cond are clauses
;; predicate: expression whose value is interpreted as true or false
;; conditional statements are evaluated as...:
;; the first predicate <p1> gets evaluated. if fales, then <p2> gets evaluated. and so on until a true value is found. if that predicate is true, it returns its corresponding <e>.

;; <e> is called the consequent expression. the expression that is returned if its predicate turns true.
;; undefined returns (the value of cond is) if none of the predicates return true.
;; predicate is used for procedures that return true or false as well as for expressions that evaluate true or false

;; else can be used in place of the predicate in the cond at the end :  (define (abs x)
;;     (cond ((< x 0) (-x))
;;           (else x)))
;; where else is saying to return x if it does not meet any of the other requirements (aka if the first cond statement is false)
;; we can also eliminate the word else entirely and it still function the same way: (define (abs x)
;;                 (if (< x 0)
;;                     (- x)
;;                     x))
;; if is a restricted type conditional and has a general form expression of:
;; (if <predicate> <consequent> <alternative>)
;; step1: evaluate predicate, if returned true, evaluate the consequent and return its value. otherwise, return the alternative if not true.
;; primitive predicate are : +, -, <, >, = etc.
;; compound predicates are : and <> ...<>, or, not,
;; and: evaluates expression predicates one at a time in order in left to right and if one predicate returns false, the whole and statement returns false.
;; or: evaluates expression predicates one at a time in order, left to right, the first instance of a true predicate will return a true for the or statement. No other predicates following will be evaluated. if all predicates return false, the or expression is false.
;; not: value is inverted... if the predicate is false, it returns a true. if the predicate is true, it returns false.
;; not is an ordinary procedure.
;; or/and are special forms because the subexpressions are not necessarily all evaluated.

(define (>= x y)
  (or (> x y) (= x y)))
(>= 4 2)
;; => #t

(define (>= x y)
  (not (< x y)))
(>= 1 2)
;; => #f
;; returns false because the statement is true. i.e. 1 is less than 2

10
;;10

(+ 5 3 4)
;;12

(- 9 1)
;;8

(/ 6 2)
;;3

(+ (* 2 4) (- 4 6))
;;6

(define a 3)
;;void

(define b (+ a 1))
;;void

(+ a b (* a b))
;;19

(= a b)
;;#f

(if (and (< b a) (< b (* a b)))
    b
    a) 
;;3 (or value of a)

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
;;16

(+ 2 (if (> b a) b a))
;;6

(* (cond ((> a b) b)
         ((< a b) a)
         (else -1))
   (+ a 1))
;;12

;; exercise 1.2
(/ (+ 5 (- 2 (- 3 (+ 6 (/ 1 5))))) (* 3 (- 6 2) (- 2 7)))
;; -17/100

;;exercise 1.3
(define (sum-of-squares x y)
  (+ (* x x) (* y y)))
(define (greater-sum a b c)
  (cond ((or (> a b c) (> b a c)) (sum-of-squares b a))
        ((or (> b c a) (> c b a)) (sum-of-squares c b))
        ((or (> c a b) (> a c b)) (sum-of-squares a c))))
(greater-sum 1 2 3)


;; exercise 1.4 steve pg 185 
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
(a-plus-abs-b 1 -3)
;; a-plus-abs-b is the name and it takes a and b as parameters
;; if b is greater than 0,return a +, if it is not, return a -
;; then take the result of the b greater than function and either add or subtract a and b. in our case, -3 is less than 0 so it will return a - to wich a and b are subtracted from each other giving us 4

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      (y)))

(test 0 p)
;; applicative order evaluates everything initially.
;; normal order only evaluates what is used.

;; section 1.1.7

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(good-enough? 200 4000)

(define (sqrt x)
  (sqrt-iter 1.0 x))
;; guess 1 x 3
(sqrt 9)
(sqrt 282828282828282)
(sqrt (sqrt (sqrt 6)))
(sqrt -0.0321)

(good-enough? .001 .002)

;; (define (square x) (* x x))

;; exercise 1.6
;; when creating new-if it is an applicative order function because i cannot create a normal order function. Even though cond is a normal order by default, putting it in parens within the new-if applicative makes my new if function applicative even though the cond is still normal order. what happens when running the sqrt-iter function, the applicative order function of newif makes it so each parameter is evaluated. so, when the sqrt iter function is run, both then and else statements are evaluated and looped. it will not be satisfied since it is supposed to run through each of the parameters (looping it in the process...so it never ends).


;; exercise 1.7
;; It is not effective for small numbers because there comes a point where the number is smaller than the variant number, thus making any of the numbers good enough when it really isnt good enough. For large numbers, it will take too much time for the function to run to find a number within such small variants. It is not efficient.

(define (good-enough? guess sqrt-num)
  (< (abs (- (square guess) sqrt-num))
     (* (- (square guess) sqrt-num) 0.01)))

;; command mode: caw changes a word. insert mode comes on, next time, just type . repeats previous command.

(sqrt 16000)
(square 126.49)

;; daw delete a word and spaces around
;; diw deletes just word
;; ci ( cuts text in parens then hit escape and hit p ... it pastes the text back in.
;; yaw yanks a word
;; yi ( copies all text in parens


;; exercise 1.8

(define (cube x) (* x x x))

(define (cube-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (cube-root x)
  (cube-iter 1.0 x))

(cube-root 27)
(cube-root 90)
(cube-root 0.0098)

;; section 1.2

;; Steve at pg 214

;; Procedure: a pattern for the local evolution of a computational process.
;; it specifies how each stage of the process is built upon the previous stage.

;; linear recursive process: breaks down a equation and then simplifies it.

;; Cx then b... brings up buffer to open document

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 5)

;; This is called a recursive process....also linear recursive process: in which the information needed to keep track of grows linearly with n (aka porportionally)
;; Do not confuse recursive process with recursive procedure. Recursive procedure is the syntactic fact that the procedure calls itself. Recursive process talks about how the process evolves; not the procedure. 
;; factorial n says... if n equals one, return the value 1. otherwise, return the result of this function: multiple n by n - 1 ... using recursion to find the new value of n each time.

(factorial 10)

;; This next function is an iterative process...it is defined by a fixed number of state variables.
;; This process only needs to keep track of three variables instead of keeping track of each end value of the linear modle.
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;; can we say that fact-iter is recursive and that factorial is iterative?
(factorial 6)
;; i hate you math

;; tail recursive: 

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

(= a 0)
;; page 48

;; Steve is on pg 456

;; Exercise 1.9

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
(define (+ a b)
  (if (= a 0)
      b
      ((+ (dec a) (inc b)))))

;; the first function is recursive. it requires another function to solve to be able to continue forward.
;; the second function is iterative.

;;Excercise 1.10

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
(A 1 n)

;; for this to evaluate 1, 10... it has to go through A in two different locations. the first time solving for y at the very end will loop through the function enough times to satisfy a number. then it goes through the x portion right after else.

(define (f n) (A 0 n)) ;; computes 2*n
(define (g n) (A 1 n)) ;; computes 2^n
(define (h n) (A 2 n)) ;; computes 2^2^2...to the nth degree


;;Exercise 1.11

;;recursive process:
(define (f n)
  (cond ((< n 3) n)
       (else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))))

(f 5)

;;iterative process:
(define (f n)
  (define f-iter a b c count)
  (if (= count 0) a
      (f-iter )))

;;come back to this... yuk

;;Exercise 1.12

(define (pascal-triangle r c)
  (cond ((> c r) 0)
        ((< c 0) 0)
        ((= c 1) 1)
        ((+ (pascal-triangle (- r 1) (- c 1))
             (pascal-triangle (- r 1) c)))))

(pascal-triangle 3 3)
(pascal-triangle 4 3)
;; the recursive process goes back to find the rows and columns used previous to the numbers we call out. 4 and 3 will go up a row and back a column then add that to the up-row and same column.

;;Exercise 1.13

;;no thank you.


;;Section 1.2.3

;;Order of growth measures the resources required by the process.

;; n = size of problem
;; R(n) = amount of required resources

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount)
                     (first-denomination kinds-of-coins))
                 kinds-of-coins))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 11)


;; redoing section 1.2.3

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6)

(define (factorial n)
  (fact-iter 1 1 n))

(define (factorial n)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;;--------------------------------------------------
;; *** Exercise 1.9 ***


(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

;; 4 does not equal 0 so it will not return anything. Instead it will go straight to the next step. decrease 4 by 1 to give 3, and return 5. process that 

;; This procedure is recursive - it requires that the computer hold more information the further more numbers that are evaluated. Once it reaches so the a = 0, then it will start to do the remaining math to figure out what b will be to return it.

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

;; 4 doesn't equal 0 so it will not return 5. Then it decreases 4 by 1 to give 3, and increases 5 by 1 to give 6. New a b is 3 6. 3 is not equal to 0 so it does not return our new b which is 6. It decreases our 3 by 1 to 2, and increases 6 by 1 to 7. Our new a b is 2 7. Is 2 equal to 0, no, so it decreases our new a down to 1 and increases our new b up to 8. 1 8 is our new a b. 1 does not equal 0 so it decreases 1 by 1 to give 0, then increases 8 to 9. New a b is 0 9. 0 equals 0 so it returns 9 and we are left at that.
;; This procedure is iterative - this evaluates a and b every time. we can stop the process mid-process and still be able to pick it back up later. It stores the most current numbers. 


;;-----------------------------
;; *** Exercise 1.10 ***

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (= x 1)
                 (A x (- y 1))))))

;;x is 1 y is 10...
;; x  y
(A 1 10)
;; returns 10
(A 2 4)
;; returns 4
;; y = 0? no, x = 0? no, y = 1? no, 10 - 1 = 9, x = 1 y = 9.
;; 

;; capital J in command mode joins lines

