<h1> Evidence 3 - Demonstration of a Programming Paradigm </h1>

Santiago Martin del Campo Soler  
Date: May - 21 - 2026  

<h2> Description </h2>

<p>
In this project, a competitive programming problem was selected in order to demonstrate the use of one of the programming paradigms studied during the TC2037 Computational Methods Implementations) course.
</p>

<p>
The selected problem is <b>Helpful Maths (339A)</b> from Codeforces. In this problem, the program receives a mathematical expression made with the numbers 1, 2, and 3, separated by plus signs. The objective is not to solve the mathematical sum, but to reorder the numbers from smallest to largest.
</p>

<p>
For example, if the input is:
</p>

<pre>
3+2+1
</pre>

<p>
The expected output is:
</p>

<pre>
1+2+3
</pre>

<p>
I chose this problem because it is simple to understand, but it still allows me to show how a programming paradigm changes the way a solution is designed. In this case, the 
problem can be seen as a transformation process: first the string is divided, then the values are ordered, and finally the expression is built again.
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
  <li>The string is split into a list of values.</li>
  <li>The list is sorted.</li>
  <li>The sorted values are joined again using plus signs.</li>
</ul>

<p>
This fits functional programming because the solution is mainly built using functions that receive data and return new data, instead of depending on many mutable variables.
</p>

<h2> Models </h2>

<h3> Functional Process </h3>

<p>
The functional process is based on a sequence of transformations. Each function has one clear task and passes its result to the next function.
</p>

<img width="121" height="421" alt="SolutionDiagram drawio" src="https://github.com/user-attachments/assets/20535e57-0cf6-49cd-aa9e-be6b0e92f0b2" />

<h3>Example Diagram of the Functional Process</h3>

<img width="121" height="421" alt="ExFuncDiagram drawio" src="https://github.com/user-attachments/assets/4dae72f6-36cc-4018-a53c-be7ad69a4271" />

<h2> Implementation </h2>

<h3> Usage of Racket </h3>

<p>
The solution was implemented in Racket. I chose to implement this solution in Racket because its built-in list handling and function composition make it a natural fit for the functional paradigm.
</p>

<h3> Main Functions </h3>

<ul>
  <li><b>parse-expression:</b> separates the input expression using the plus sign.</li>
  <li><b>sort-values:</b> sorts the values from smallest to largest.</li>
  <li><b>build-expression:</b> joins the sorted values again with plus signs.</li>
  <li><b>solve:</b> connects all the previous functions.</li>
</ul>

<h3> Code </h3>

```racket

(define (parse-expression expr)
  (string-split expr "+"))

(define (sort-values values)
  (sort values string<?))

(define (build-expression values)
  (string-join values "+"))

(define (solve expr)
  (build-expression
   (sort-values
    (parse-expression expr))))
```
    
<h3> Explanation of the Functional Solution </h3>

<p>
The solution uses the functional paradigm because each part of the program is separated
into functions. These functions are then composed to create the complete answer.
</p>

<p>
The function <code>solve</code> shows this clearly, because it takes the original expression,
parses it, sorts it, and then builds the final expression.
</p>

<pre>
solve = build-expression(
                          sort-values(
                                      parse-expression(input)))
</pre>

<p>
This makes the logic easier to follow because every step has a specific purpose.
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
  (run-test "3+2+1" "1+2+3")
  (run-test "1+1+3+2" "1+1+2+3")
  (run-test "2" "2")
  (run-test "3+3+2+1+1" "1+1+2+3+3")
  (run-test "1+2+3" "1+2+3")
  (run-test "2+1" "1+2")

  ;; Pruebas incorrectas
  (run-test "3+2+1" "3+2+1")
  (run-test "2+1" "2+1"))
```

<h3> Testing Interpretation</h3>
<p>
These tests are useful because they allow me to verify the program's correctness quickly
without entering each input manually. They also help check important cases such as
unordered expressions, repeated numbers, and already sorted inputs.
</p>

<h3> Testing Results </h3>

<p>
After running the automated tests, the following results were obtained:
</p>

<img width="626" height="166" alt="Automated testing results" src="https://github.com/user-attachments/assets/178ce643-6dc0-4823-8332-22716daa20bc" />
<h2> Analysis </h2>

<h3> Time Complexity </h3>

<p>
The program splits the expression, sorts the values, and joins them again.
</p>

<ul>
  <li>Splitting the expression takes <code>O(n)</code>.</li>
  <li>Sorting the values takes <code>O(n log n)</code>.</li>
  <li>Joining the final expression takes <code>O(n)</code>.</li>
</ul>

<p>
In this process, the most expensive operation in the functional solution is sorting. In general, efficient sorting algorithms require <code>O(n log n)</code> time, because the list is divided and reorganized while elements are compared. In this case, <code>n</code> represents the number of values in the expression.
</p>

<p>
Since sorting is the most expensive operation compared to splitting and joining,
the final time complexity is:
</p> 

<pre>
O(n log n)
</pre>

<h3> Space Complexity </h3>

<p>
The program stores the separated values in a list. Because this list depends on the
amount of terms in the input, the space complexity is:
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
