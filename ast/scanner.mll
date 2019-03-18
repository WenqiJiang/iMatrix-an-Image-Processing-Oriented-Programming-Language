(* Ocamllex scanner for MicroC *)

{ open Microcparse }

let digit = ['0' - '9']
let digits = digit+

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| "//"     { inlinecom lexbuf }
| '('      { LPAREN }                   (* () [] {} *)
| ')'      { RPAREN }
| '['      { LBRACK }
| ']'      { RBRACK }
| '{'      { LBRACE }
| '}'      { RBRACE }
| ';'      { SEMI }                     (* split *)
| ','      { COMMA }
| '+'      { PLUS }                     (* arithmatic *)
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '%'      { MOD }
| '='      { ASSIGN }
| "=="     { EQ }                       (* logical *)
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "&&"     { AND }
| "||"     { OR }
| "!"      { NOT }
| "if"     { IF }                        (* conditional & loops *)
| "else"   { ELSE }
| "for"    { FOR }
| "while"  { WHILE }
| "break"  { BREAK }
| "continue"  { CONTINUE }
| "return" { RETURN }
| "int"    { INT }                       (* data type *)
| "bool"   { BOOL }
| "float"  { FLOAT }
| "char"   { CHAR }
| "string" { STRING }
| "matrix" { MATRIX }
| "img"    { IMG }
| "void"   { VOID }
| "struct" { STRUCT }
| "true"   { BLIT(true)  }               (* bool *)
| "false"  { BLIT(false) }
| digits as lxm { LITERAL(int_of_string lxm) }  (* int *)
| digits '.'  digit* ( ['e' 'E'] ['+' '-']? digits )? as lxm { FLIT(lxm) }  (* float *)
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']*     as lxm { ID(lxm) }    (* ID *)
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
