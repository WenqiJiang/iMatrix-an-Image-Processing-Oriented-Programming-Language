type token =
  | LPAREN
  | RPAREN
  | LBRACK
  | RBRACK
  | LBRACE
  | RBRACE
  | SEMI
  | COMMA
  | DOT
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | MODULO
  | POWER
  | SELFPLUS
  | SELFMINUS
  | MATMUL
  | ASSIGN
  | EQ
  | NEQ
  | LT
  | LEQ
  | GT
  | GEQ
  | AND
  | OR
  | NOT
  | IF
  | ELSE
  | FOR
  | WHILE
  | BREAK
  | CONTINUE
  | RETURN
  | INT
  | BOOL
  | FLOAT
  | CHAR
  | STRING
  | MAT
  | IMG
  | VOID
  | STRUCT
  | LITERAL of (int)
  | BLIT of (bool)
  | ID of (string)
  | FLIT of (string)
  | STRING_LITERAL of (string)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
