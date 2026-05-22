#lang racket

;; Separar expresion respecto los +
(define (parse-exp exp)
  (string-split exp "+"))

;; Ordenar valores como strings
(define (sort-values values)
  (sort values string<?))

;; Creacion de Output
(define (build-output values)
  (string-join values "+"))

;; Solver, recibe input, ordena y construye output
(define (solve expression)
  (build-output
   (sort-values
    (parse-exp expression))))

;; Ejecuta una prueba y muestra si pasó o falló
(define (run-test input expected)
  (define result (solve input))
  (define passed? (equal? result expected))

  (displayln
   (string-append
    "Input: " input
    " | Expected: " expected
    " | Result: " result
    " | Passed: " (if passed? "true" "false")))
  passed?)

;; Funcion para ejecutar pruebas automatizadas
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

(run-tests)