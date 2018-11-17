%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <math.h>
extern void yyerror(const char *);
void count(void);
void comment (void);
%}

/* KEYWORDS */
AUTO		"auto"
ENUM		"enum"
RESTRICT	"restrict"
UNSIGNED	"unsigned"
BREAK		"break"
EXTERN		"extern"
RETURN		"return"
VOID		"void"
CASE		"case"
FLOAT		"float"
SHORT		"short"
VOLATILE	"volatile"
CHAR		"char"
FOR			"for"
SIGNED		"signed"
WHILE		"while"
CONST		"const"
GOTO		"goto"
SIZEOF		"sizeof"
_BOOL		"_Bool"
CONTINUE	"continue"
IF			"if"
STATIC		"static"
_COMPLEX	"_Complex"
DEFAULT		"default"
INLINE		"inline"
STRUCT		"struct"
_IMAGINARY	"_Imaginary"
DO			"do"
INT			"int"
SWITCH		"switch"
DOUBLE		"double"
LONG		"long"
TYPEDEF		"typedef"
ELSE		"else"
REGISTER	"register"
UNION		"union"

/* IDENTIFIERS */
DIGIT						[0-9]
IDENTIFIER_NONDIGIT 		[a-zA-Z_]+
IDENTIFIER 					{IDENTIFIER_NONDIGIT}({IDENTIFIER_NONDIGIT}|{DIGIT})*

/* CONSTANTS */
NONZERO_DIGIT				[1-9]
NONZERO_INTEGER_CONSTANT	{NONZERO_DIGIT}({NONZERO_DIGIT}|{DIGIT})*
INTEGER_CONSTANT			{NONZERO_INTEGER_CONSTANT}|"0"
CONSTANT					{INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{ENUMERATION_CONSTANT}|{CHARACTER_CONSTANT}
DIGIT_SEQUENCE				[0-9]+
SIGN 						"+"|"-"
EXPONENT_PART				("e"{SIGN}?{DIGIT_SEQUENCE})|("E"{SIGN}?{DIGIT_SEQUENCE})
FRACTIONAL_CONSTANT			({DIGIT_SEQUENCE}?"."{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}".")
FLOATING_CONSTANT			({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART})
ENUMERATION_CONSTANT		{IDENTIFIER}
ESCAPE_SEQUENCE				"\'"|"\""|"\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"
C_CHAR 						{ESCAPE_SEQUENCE}|[^("\'"|"\\"|"\n")]
C_CHAR_SEQUENCE				{C_CHAR}+
CHARACTER_CONSTANT			'(\\[tvrnafb\\]|[^\\'])'

/* STRING LITERALS */
S_CHAR  					{ESCAPE_SEQUENCE}|[^("\""|"\\"|"\n")]
S_CHAR_SEQUENCE				{S_CHAR}+
STRING_LITERAL 				\"(\\.|[^"\\])*\"

/* PUNCTUATORS */
PUNCTUATORA					"["|"]"|"("|")"|"{"|"}"|"."|"->"
PUNCTUATORB					"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"
PUNCTUATORC					"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"
PUNCTUATORD					"?"|":"|";"|"..."|","|"#"
PUNCTUATORE					"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="
PUNCTUATOR 					{PUNCTUATORA}|{PUNCTUATORB}|{PUNCTUATORC}|{PUNCTUATORD}|{PUNCTUATORE}

/* WHITE SPACE */
WS 		[ \t\n]

%%
{AUTO}			{ return AUTO; }
{ENUM}			{ return ENUM; }
{RESTRICT}		{ return RESTRICT; }
{UNSIGNED}		{ return UNSIGNED; }
{BREAK}			{ return BREAK; }
{EXTERN}		{ return EXTERN; }
{RETURN}		{ return RETURN; }
{VOID}			{ return VOID; }
{CASE}			{ return CASE; }
{FLOAT}			{ return FLOAT; }
{SHORT}			{ return SHORT; }
{VOLATILE}		{ return VOLATILE; }
{CHAR}			{ return CHAR; }
{FOR}			{ return FOR; }
{SIGNED}		{ return SIGNED; }
{WHILE}			{ return WHILE; }
{CONST}			{ return CONST; }
{GOTO}			{ return GOTO; }
{SIZEOF}		{ return SIZEOF; }
{_BOOL}			{ return _BOOL; }
{CONTINUE}		{ return CONTINUE; }
{IF}			{ return IF; }
{STATIC}		{ return STATIC; }
{_COMPLEX}		{ return _COMPLEX; }
{DEFAULT}		{ return DEFAULT; }
{INLINE}		{ return INLINE; }
{STRUCT}		{ return STRUCT; }
{_IMAGINARY}	{ return _IMAGINARY; }
{DO}			{ return DO; }
{INT}			{ return INT; }
{SWITCH}		{ return SWITCH; }
{DOUBLE}		{ return DOUBLE; }
{LONG}			{ return LONG; }
{TYPEDEF}		{ return TYPEDEF; }
{ELSE}			{ return ELSE; }
{REGISTER}		{ return REGISTER; }
{UNION}			{ return UNION; }

{IDENTIFIER}	{ return IDENTIFIER; }

{INTEGER_CONSTANT}	{ return INTEGER_CONSTANT; }

{FLOATING_CONSTANT}	{ return FLOATING_CONSTANT; }

{CHARACTER_CONSTANT} { return CHARACTER_CONSTANT; }

{STRING_LITERAL} { return STRING_LITERAL; }

{PUNCTUATOR}	{
	if(strcmp(yytext,"[") == 0) return '[';
	if(strcmp(yytext,"]") == 0) return ']';
	if(strcmp(yytext,"{") == 0) return '{';
	if(strcmp(yytext,"}") == 0) return '}';
	if(strcmp(yytext,"(") == 0) return '(';
	if(strcmp(yytext,")") == 0) return ')';
	if(strcmp(yytext,".") == 0) return '.';
	if(strcmp(yytext,"*") == 0) return '*';
	if(strcmp(yytext,"+") == 0) return '+';
	if(strcmp(yytext,"-") == 0) return '-';
	if(strcmp(yytext,"~") == 0) return '~';
	if(strcmp(yytext,"!") == 0) return '!';
	if(strcmp(yytext,"/") == 0) return '/';
	if(strcmp(yytext,"%") == 0) return '%';
	if(strcmp(yytext,"<") == 0) return '<';
	if(strcmp(yytext,">") == 0) return '>';
	if(strcmp(yytext,"?") == 0) return '?';
	if(strcmp(yytext,":") == 0) return ':';
	if(strcmp(yytext,";") == 0) return ';';
	if(strcmp(yytext,",") == 0) return ',';
	if(strcmp(yytext,"#") == 0) return '#';
	if(strcmp(yytext,"=") == 0) return '=';
	if(strcmp(yytext,"^") == 0) return '^';
	if(strcmp(yytext,"|") == 0) return '|';
	
	if(strcmp(yytext,"->") == 0) return ACC;
	if(strcmp(yytext,"++") == 0) return INC;
	if(strcmp(yytext,"--") == 0) return DEC;
	if(strcmp(yytext,"&") == 0) return AMP;
	if(strcmp(yytext,"<<") == 0) return SHIFT_L;
	if(strcmp(yytext,">>") == 0) return SHIFT_R;
	if(strcmp(yytext,"<=") == 0) return LTE;
	if(strcmp(yytext,">=") == 0) return GTE;
	if(strcmp(yytext,"==") == 0) return EQ;
	if(strcmp(yytext,"!=") == 0) return NEQ;
	if(strcmp(yytext,"&&") == 0) return AND;
	if(strcmp(yytext,"||") == 0) return OR;
	if(strcmp(yytext,"...") == 0) return DOTS;
	if(strcmp(yytext,"*=") == 0) return STAR_EQ;
	if(strcmp(yytext,"/=") == 0) return DIV_EQ;
	if(strcmp(yytext,"%=") == 0) return MOD_EQ;
	if(strcmp(yytext,"+=") == 0) return PLUS_EQ;
	if(strcmp(yytext,"-=") == 0) return MINUS_EQ;
	if(strcmp(yytext,"<<=") == 0) return SHIFT_LEQ;
	if(strcmp(yytext,">>=") == 0) return SHIFT_REQ;
	if(strcmp(yytext,"&=") == 0) return BIN_AND_EQ;
	if(strcmp(yytext,"^=") == 0) return BIN_XOR_EQ;
	if(strcmp(yytext,"|=") == 0) return BIN_OR_EQ;
}

"/*"			{ comment(); }
"//".*  	   	{  /* consume //-comment */ }

{WS}		{/* Ignore whitespace */}
%%%%

int column = 0;
void count(void) {
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n') column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	ECHO;
}
void comment(void) {
	char c, prev = 0;
	while ((c = input()) != 0) {     /* (EOF maps to 0) */
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	error("unterminated comment");
}
