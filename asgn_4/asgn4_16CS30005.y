%{ /* C Declarations and Definitions */
	#include <string.h>
	#include <stdio.h>

	extern int yylex();
	void yyerror(char *s);
%}

%union {
int intval;
}

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token _BOOL _COMPLEX _IMAGINARY
%token STRUCT UNION ENUM
%token BREAK CASE CONTINUE DEFAULT DO IF ELSE FOR GOTO WHILE SWITCH SIZEOF
%token RETURN

%token DOTS SHIFT_REQ SHIFT_LEQ PLUS_EQ MINUS_EQ STAR_EQ
%token DIV_EQ MOD_EQ BIN_AND_EQ BIN_XOR_EQ BIN_OR_EQ SHIFT_R SHIFT_L 
%token INC DEC ACC AMP AND OR LTE GTE EQ NEQ

%token IDENTIFIER STRING_LITERAL PUNCTUATOR COMMENT
%token INTEGER_CONSTANT FLOATING_CONSTANT CHARACTER_CONSTANT

%start translation_unit

%%

primary_expression
	: IDENTIFIER
	| constant
	| STRING_LITERAL
	| '(' expression ')'
	{fprintf(stderr,"***Rule --> primary_expression***\n");}
	;

constant
	: INTEGER_CONSTANT 
	| FLOATING_CONSTANT 
	| CHARACTER_CONSTANT
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression ACC IDENTIFIER
	| postfix_expression INC
	| postfix_expression DEC
	| '(' type_name ')' '{' initializer_list '}'
	|  '(' type_name ')' '{' initializer_list ',' '}'
	{fprintf(stderr,"***Rule --> postfix_expression***\n");}
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	{fprintf(stderr,"***Rule --> argument_expression_list***\n");}
	;

unary_expression
	: postfix_expression
	| INC unary_expression
	| DEC unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	{fprintf(stderr,"***Rule --> unary_expression***\n");}
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	{fprintf(stderr,"***Rule --> unary_operator***\n");}
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	{fprintf(stderr,"***Rule --> cast_expression***\n");}
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	{fprintf(stderr,"***Rule --> multiplicative_expression***\n");}
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	{fprintf(stderr,"***Rule --> additive_expression***\n");}
	;

shift_expression
	: additive_expression
	| shift_expression SHIFT_L additive_expression
	| shift_expression SHIFT_R additive_expression
	{fprintf(stderr,"***Rule --> shift_expression***\n");}
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LTE shift_expression
	| relational_expression GTE shift_expression
	{fprintf(stderr,"***Rule --> relational_expression***\n");}
	;

equality_expression
	: relational_expression
	| equality_expression EQ relational_expression
	| equality_expression NEQ relational_expression
	{fprintf(stderr,"***Rule --> equality_expression***\n");}
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	{fprintf(stderr,"***Rule --> and_expression***\n");}
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	{fprintf(stderr,"***Rule --> exclusive_or_expression***\n");}
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	{fprintf(stderr,"***Rule --> inclusive_or_expression***\n");}
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND inclusive_or_expression
	{fprintf(stderr,"***Rule --> logical_and_expression***\n");}
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR logical_and_expression
	{fprintf(stderr,"***Rule --> logical_or_expression***\n");}
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	{fprintf(stderr,"***Rule --> conditional_expression***\n");}
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	{fprintf(stderr,"***Rule --> assignment_expression***\n");}
	;

assignment_operator
	: '='
	{fprintf(stderr,"***Rule --> assignment_operator***\n");}
	| STAR_EQ
	| DIV_EQ
	| MOD_EQ
	| PLUS_EQ
	| MINUS_EQ
	| SHIFT_LEQ
	| SHIFT_REQ
	| BIN_AND_EQ
	| BIN_XOR_EQ
	| BIN_OR_EQ
	{fprintf(stderr,"***Rule --> assignment_operator***\n");}
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	{fprintf(stderr,"***Rule --> expression***\n");}
	;

constant_expression
	: conditional_expression
	{fprintf(stderr,"***Rule --> constant_expression***\n");}
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	{fprintf(stderr,"***Rule --> declaration***\n");}
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	| function_specifier 
	| function_specifier declaration_specifiers
	{fprintf(stderr,"***Rule --> declaration_specifiers***\n");}
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	{fprintf(stderr,"***Rule --> init_declarator_list***\n");}
	;

init_declarator
	: declarator
	| declarator '=' initializer
	{fprintf(stderr,"***Rule --> init_declarator***\n");}
	;

storage_class_specifier
	: EXTERN
	| STATIC
	| AUTO
	| REGISTER
	{fprintf(stderr,"***Rule --> storage_class_specifier***\n");}
	;

type_specifier
	: VOID
	| CHAR
	| SHORT
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| _BOOL
	| _COMPLEX
	| _IMAGINARY
	| enum_specifier
	{fprintf(stderr,"***Rule --> type_specifier***\n");}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	{fprintf(stderr,"***Rule --> specifier_qualifier_list***\n");}
	;


enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM '{' enumerator_list ',' '}'
	| ENUM IDENTIFIER '{' enumerator_list ',' '}'
	| ENUM IDENTIFIER
	{fprintf(stderr,"***Rule --> enum_specifier***\n");}
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	{fprintf(stderr,"***Rule --> enumerator_list***\n");}
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression
	{fprintf(stderr,"***Rule --> enumerator***\n");}
	;

type_qualifier
	: CONST
	| VOLATILE
	| RESTRICT
	{fprintf(stderr,"***Rule --> type_qualifier***\n");}
	;
function_specifier
	: INLINE
	{fprintf(stderr,"***Rule --> function_specifier***\n");}
	;
declarator
	: pointer direct_declarator
	| direct_declarator
	{fprintf(stderr,"***Rule --> declarator***\n");}
	;

direct_declarator
	: IDENTIFIER
	| '(' declarator ')'
	| direct_declarator '['  type_qualifier_list_opt assignment_expression_opt ']'
	| direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']'
	| direct_declarator '[' type_qualifier_list_opt '*' ']'
	| direct_declarator '(' parameter_type_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	{fprintf(stderr,"***Rule --> direct_declarator***\n");}
	;

type_qualifier_list_opt
	: %empty
	| type_qualifier_list
	{fprintf(stderr,"***Rule --> type_qualifier_list_opt***\n");}
	;
assignment_expression_opt
	: %empty
	| assignment_expression
	{fprintf(stderr,"***Rule --> assignment_expression_opt***\n");}
	;

pointer
	: '*'
	| '*' type_qualifier_list
	| '*' pointer
	| '*' type_qualifier_list pointer
	{fprintf(stderr,"***Rule --> pointer***\n");}
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	{fprintf(stderr,"***Rule --> type_qualifier_list***\n");}
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' DOTS
	{fprintf(stderr,"***Rule --> parameter_type_list***\n");}
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	{fprintf(stderr,"***Rule --> parameter_list***\n");}
	;

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers
	{fprintf(stderr,"***Rule --> parameter_declaration***\n");}
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	{fprintf(stderr,"***Rule --> identifier_list***\n");}
	;

type_name
	: specifier_qualifier_list
	{fprintf(stderr,"***Rule --> type_name***\n");}
	;

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	{fprintf(stderr,"***Rule --> initializer***\n");}
	;

initializer_list
	: initializer
	| designation initializer
	| initializer_list ',' initializer
	| initializer_list ',' designation initializer
	{fprintf(stderr,"***Rule --> initializer_list***\n");}
	;

designation
	: designator_list '='
	{fprintf(stderr,"***Rule --> designation***\n");}
	;

designator_list
	: designator
	| designator_list designator
	{fprintf(stderr,"***Rule --> designator_list***\n");}
	;

designator
	: '[' constant_expression ']'
	| '.' IDENTIFIER
	{fprintf(stderr,"***Rule --> designator***\n");}
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	{fprintf(stderr,"***Rule --> statement***\n");}
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	{fprintf(stderr,"***Rule --> labeled_statement***\n");}
	;

compound_statement
	: '{' '}'
	| '{' block_item_list '}'
	{fprintf(stderr,"***Rule --> compound_statement***\n");}
	;

block_item_list
	: block_item
	| block_item_list block_item
	{fprintf(stderr,"***Rule --> block_item_list***\n");}
	;

block_item
	: declaration
	| statement
	{fprintf(stderr,"***Rule --> block_item***\n");}
	;


expression_statement
	: ';'
	| expression ';'
	{fprintf(stderr,"***Rule --> expression_statement***\n");}
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement
	| SWITCH '(' expression ')' statement
	{fprintf(stderr,"***Rule --> selection_statement***\n");}
	;

iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' expression_statement expression_statement ')' statement
	| FOR '(' expression_statement expression_statement expression ')' statement
	| FOR '(' ';' ';' ')' statement
	| FOR '(' declaration expression ';' ')' statement
	| FOR '(' ';' expression ')' statement
	| FOR '(' declaration ';' ')' statement
	| FOR '(' declaration expression ';' expression ')' statement
	| FOR '(' ';' ')' statement
	{fprintf(stderr,"***Rule --> iteration_statement***\n");}
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'
	
	{fprintf(stderr,"***Rule --> jump_statement***\n");}
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	{fprintf(stderr,"***Rule --> translation_unit***\n");}
	;

external_declaration
	: function_definition
	| declaration
	{fprintf(stderr,"***Rule --> external_declaration***\n");}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	| declaration_specifiers declarator compound_statement
	{fprintf(stderr,"***Rule --> function_definition***\n");}
	;
declaration_list
	: declaration
	| declaration_list declaration
	{fprintf(stderr,"***Rule --> declaration_list***\n");}
	;

%%
void yyerror(char *s) {
	fprintf(stderr,"***Rule --> \nERROR: %s***\n",s);
}
