#lang racket

(require rackunit)

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

;; Funcion para ejecutar pruebas
(define (run-tests)
  (check-equal? (solve "3+2+1") "1+2+3")
  (check-equal? (solve "1+1+3+2") "1+1+2+3")
  (check-equal? (solve "2") "2")
  (check-equal? (solve "3+3+2+1+1") "1+1+2+3+3")
  (check-equal? (solve "1+2+3") "1+2+3")
  (check-equal? (solve "2+1") "1+2")
  (displayln "All tests passed"))

(run-tests)