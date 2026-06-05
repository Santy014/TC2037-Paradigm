#lang racket

;; Convierte un caracter numerico a numero
(define (char->num ch)
  (- (char->integer ch) (char->integer #\0)))

;; Revisa si el caracter es un operador permitido
(define (operator? ch)
  (or (char=? ch #\+)
      (char=? ch #\*)
      (char=? ch #\^)))

;; Revisa si el caracter es valido: numero u operador
(define (valid-char? ch)
  (or (char-numeric? ch)
      (operator? ch)))

;; Revisa que todos los caracteres sean validos
(define (valid-chars? chars)
  (cond
    [(empty? chars) #t]
    [(valid-char? (first chars))
     (valid-chars? (rest chars))]
    [else #f]))

;; Valida que el orden sea: numero operador numero operador...
(define (valid-structure? chars expected-number?)
  (cond
    ;; Al terminar, debe haber terminado en numero
    [(empty? chars) (not expected-number?)]

    ;; Si espera numero, el caracter actual debe ser numerico
    [expected-number?
     (and (char-numeric? (first chars))
          (valid-structure? (rest chars) #f))]

    ;; Si no espera numero, entonces debe encontrar operador
    [else
     (and (operator? (first chars))
          (valid-structure? (rest chars) #t))]))

;; Junta todas las validaciones de la expresion
(define (valid-expression? expression)
  (define chars (string->list expression))
  (and
   (not (string=? expression ""))
   (valid-chars? chars)
   (valid-structure? chars #t)))

;; Convierte un operador de caracter a string
;; Ejemplo: #\+ -> "+"
(define (operator->string ch)
  (string ch))

;; Separa la expresion en numeros y operadores
;; Ejemplo: "3+2*1^3" -> '(3 "+" 2 "*" 1 "^" 3)
(define (split-expression chars)
  (cond
    [(empty? chars) '()]

    ;; Si encuentra numero, lo convierte a numero
    [(char-numeric? (first chars))
     (cons (char->num (first chars))
           (split-expression (rest chars)))]

    ;; Si encuentra operador, lo guarda como string
    [(operator? (first chars))
     (cons (operator->string (first chars))
           (split-expression (rest chars)))]))

;; Evalua primero las potencias
;; Busca patrones: numero "^" numero
(define (eval-power elements)
  (cond
    [(empty? elements) '()]
    [(empty? (rest elements)) elements]

    ;; Si el segundo elemento es "^", resuelve esa operacion
    [(and (>= (length elements) 3)
          (equal? (second elements) "^"))
     (cons (expt (first elements)
                 (third elements))
           (eval-power (drop elements 3)))]

    ;; Si no hay potencia, conserva el elemento y avanza
    [else
     (cons (first elements)
           (eval-power (rest elements)))]))

;; Evalua multiplicaciones despues de potencias
;; Busca patrones: numero "*" numero
(define (eval-mult elements)
  (cond
    [(empty? elements) '()]
    [(empty? (rest elements)) elements]

    ;; Si el segundo elemento es "*", multiplica
    [(and (>= (length elements) 3)
          (equal? (second elements) "*"))
     (eval-mult
      (cons (* (first elements)
               (third elements))
            (drop elements 3)))]

    ;; Si no hay multiplicacion, conserva el elemento y avanza
    [else
     (cons (first elements)
           (eval-mult (rest elements)))]))

;; Evalua sumas al final
;; Busca patrones: numero "+" numero
(define (eval-sum elements)
  (cond
    [(empty? elements) 0]
    [(empty? (rest elements)) (first elements)]

    ;; Si encuentra "+", suma el numero actual con el resto
    [(equal? (second elements) "+")
     (+ (first elements)
        (eval-sum (drop elements 2)))]

    ;; Si no encuentra "+", avanza
    [else
     (eval-sum (rest elements))]))

;; Funcion principal:
;; valida, separa y evalua por orden de operaciones
(define (solve expression)
  (if (valid-expression? expression)
      (eval-sum
       (eval-mult
        (eval-power
         (split-expression
          (string->list expression)))))
      "Invalid expression"))

;; Ejecuta una prueba individual
(define (run-test input expected expected-result)
  (define result (solve input))
  (define passed? (equal? result expected))
  (define test-correct? (equal? passed? expected-result))

  (displayln
   (string-append
    input
    " -> "
    (if test-correct? "true" "false")))

  test-correct?)

;; Ejecuta todas las pruebas automatizadas
(define (run-tests)
  ;; Casos validos correctos
  (run-test "3+2*1^3" 5 #t)
  (run-test "2+3*2" 8 #t)
  (run-test "2^3+1" 9 #t)
  (run-test "1+2+3" 6 #t)
  (run-test "3*2+1" 7 #t)
  (run-test "2^2*3+1" 13 #t)



  ;; Pruebas negativas: el resultado esperado esta mal a proposito
  (run-test "3+2*1^3" 10 #f)
  (run-test "2+3*2" 2 #f))

(run-tests)
