<h1> Evidence 3 - Demonstration of a Programming Paradigm </h1>

Santiago Martin del Campo Soler  
Date: May - 21 - 2026  

<h2> Description </h2>

<p>
In this project, a competitive programming problem was selected in order to demonstrate the use of one of the programming paradigms studied during the TC2037 Computational Methods Implementations) course.
</p>

<p>
The selected problem is based on <b>Helpful Maths (339A)</b> from Codeforces. The original
problem receives a mathematical expression made with the numbers 1, 2, and 3 separated
by plus signs, and the objective is to reorder the numbers from smallest to largest.
</p>

<p>
As feedback I got advised that I should extended the original idea by allowing more arithmetic operators:
addition +, multiplication *, and exponentiation ^.
Because of this, the program now validates and evaluates a simplified arithmetic
expression while respecting operator precedence.
</p>
<p>
For example, if the input is:
</p>

<pre>
2^2*3+1
</pre>

<p>
The expected output is:
</p>

<pre>
13
</pre>

<p>
This result is obtained because exponentiation is evaluated first, then multiplication,
and finally addition.
</p>

<p>
I chose this problem because it started as a simple string transformation problem, but it
can be extended into a more complete expression-processing problem. In this version, the
program must validate the expression, split it into numbers and operators, and evaluate
the operations according to their precedence.
</p>

<h3> Paradigm </h3>

<p>
According to Van Roy, a programming paradigm is not only a coding style, but also a way of thinking about how to solve a problem. This idea relates to Thomas Kuhn's concept of paradigm as a framework of thought,
since each programming paradigm gives the programmera different set of concepts and tools to organize the solution.
</p>

<p>
The main paradigm used in this project is the functional programming paradigm.
I decided to use this paradigm because the problem can be solved clearly through functions and data transformations.
</p>

<p>
In the functional solution, the input is transformed step by step:
</p>

<ul>
  <li>The original expression is received as a string.</li>
  <li>The expression is validated to check if its structure is correct.</li>
  <li>The string is converted into a list of numbers and operators.</li>
  <li>The program evaluates exponentiation first.</li>
  <li>Then, it evaluates multiplication.</li>
  <li>Finally, it evaluates addition.</li>
</ul>

<p>
This fits functional programming because the solution is mainly built using functions that receive data and return new data, instead of depending on many mutable variables.
</p>

<h2> Models </h2>

<h3> Functional Process </h3>

<p>
The functional process is based on a sequence of transformations. Each function has one clear task and passes its result to the next function.
</p>

<img width="121" height="601" alt="DIAGRAMA" src="https://github.com/user-attachments/assets/dadff7fa-97c1-4b53-ab82-33617f750b9b" />

<h2> Implementation </h2>

<h3> Usage of Racket </h3>

<p>
The solution was implemented in Racket because the problem can be represented as a
sequence of data transformations. Racket supports the functional paradigm by allowing the
program to be divided into small functions that receive data and return new data without
depending mainly on mutable state.
</p>

<p>
In this implementation, the expression is validated, transformed into a list of elements,
and then evaluated through separated functions according to operator precedence. This
makes the functional structure of the solution clearer than writing the whole algorithm
as a sequence of mutable steps.
</p>

<h3> Main Functions </h3>

<ul>
  <li><b>char->num:</b> converts a numeric character into a number.</li>
  <li><b>operator?:</b> checks if a character is one of the accepted operators.</li>
  <li><b>valid-char?:</b> checks if a character is valid inside the expression.</li>
  <li><b>valid-chars?:</b> verifies that all characters in the expression are valid.</li>
  <li><b>valid-structure?:</b> checks that the expression follows the structure number-operator-number.</li>
  <li><b>valid-expression?:</b> combines all validation rules.</li>
  <li><b>split-expression:</b> separates the input expression into numbers and operators.</li>
  <li><b>eval-power:</b> evaluates exponentiation operations first.</li>
  <li><b>eval-mult:</b> evaluates multiplication operations after exponentiation.</li>
  <li><b>eval-sum:</b> evaluates addition operations at the end.</li>
  <li><b>solve:</b> connects all the previous functions and returns the final result.</li>
</ul>

<h3> Code </h3>

```racket

(define (solve expression)
  (if (valid-expression? expression)
      (eval-sum
       (eval-mult
        (eval-power
         (split-expression
          (string->list expression)))))
      "Invalid expression"))

```
    
<p>
The function <code>solve</code> shows the functional structure of the solution. It first
checks if the expression is valid. If the expression is correct, it transforms the string
into a list of elements and then evaluates the operations by priority.
</p>

<pre>
solve =
  validate expression
  -> split-expression
  -> eval-power
  -> eval-mult
  -> eval-sum
</pre>

<p>
This makes the logic easier to follow because every function has a specific purpose.
Instead of solving the whole expression in one large block of code, the program separates
the problem into smaller functional transformations.
</p>

<h2> Testing </h2>

<p>
For this version of the project, I created a group of automated tests to verify that the
solution works with different input cases. The tests were written using the function
<code>run-tests</code>, which checks the result of the <code>solve</code> function with
different expressions.
</p>

<h3> Automated Test Cases </h3>

```racket
(define (run-tests)
  ;; Casos validos correctos
  (run-test "3+2*1^3" 5 #t)
  (run-test "2+3*2" 8 #t)
  (run-test "2^3+1" 9 #t)
  (run-test "1+2+3" 6 #t)
  (run-test "3*2+1" 7 #t)
  (run-test "2^2*3+1" 13 #t)

  ;; Pruebas negativas
  (run-test "3+2*1^3" 10 #f)
  (run-test "2+3*2" 6 #f))
```

<h3> Testing Interpretation</h3>

<p>
The automated tests include valid cases, invalid cases, and negative cases. Valid cases
verify that the program correctly evaluates expressions using operator precedence.
Invalid cases check that the program rejects expressions with incorrect characters or
incorrect structure.
</p>

<p>
Negative tests intentionally use wrong expected outputs. These tests are useful because
they confirm that the testing function can detect incorrect results. Therefore, a
negative test is considered correct when the program identifies the expected output as
false.
</p>

<h3> Testing Results </h3>

<p>
After running the automated tests, the following results were obtained:
</p>

<img width="623" height="485" alt="imagen" src="https://github.com/user-attachments/assets/5c83022d-44c2-4d5c-aa9a-bca10e180da3" />

<h2> Analysis </h2>

<h3> Time Complexity </h3>
<p>
Let n be the number of characters or elements in the expression. The program
processes the expression in several stages. First, it validates the expression. Then, it
splits the expression into elements. After that, it evaluates the operators according to
their precedence.
</p>

<ul>
  <li>Validating the expression takes O(n) </li>
  <li>Splitting the expression into elements takes O(n) </li>
  <li>Evaluating exponentiation takes O(n) </li>
  <li>Evaluating multiplication takes O(n) </li>
  <li>Evaluating addition takes O(n) </li>
</ul>

<p>
Since all these operations are linear and are executed one after another, the final time
complexity is:
</p>

<pre>
O(n)
</pre>

<h3> Space Complexity </h3>

<p>
The program stores the expression as a list of elements containing numbers and operators.
Because this list grows depending on the size of the input expression, the space
complexity is:
</p>

<pre>
O(n)
</pre>

<h2> Sources </h2>

<p>
Codeforces. (n.d.). <i>339A - Helpful Maths</i>. Codeforces.
https://codeforces.com/problemset/problem/339/A
</p>

<p>
Van Roy, Peter. (2009). Programming Paradigms for Dummies: What Every Programmer Should Know. 
https://webperso.info.ucl.ac.be/~pvr/VanRoyChapter.pdf
</p>

<p>
Yuila Stolin and Orit Hazzan. 2007. Students' understanding of computer science soft ideas: the case of programming paradigm. SIGCSE Bull. 39, 2 (June 2007), 65–69.
  https://doi.org/10.1145/1272848.1272887
</p>

<p>
Racket Documentation. (n.d.). <i>The Racket Reference</i>.
https://docs.racket-lang.org/reference/
</p>
