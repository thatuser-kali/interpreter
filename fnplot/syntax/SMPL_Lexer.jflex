/* Specification for ArithExp tokens */

// user customisations
package smpl.syntax;

import java_cup.runtime.*;
import java.io.IOException;
import smpl.sys.TokenException;

// JFlex directives
%%

%cup
%public

%class SmplLexer
%throws TokenException

%type java_cup.runtime.Symbol

%eofval{
	return new Symbol(sym.EOF);
%eofval}


%state STRING
%state YYCOMMENT

%char
%line

%{
    public int getChar() {
	return yychar + 1;
    }

    public int getColumn() {
    	return yycolumn + 1;
    }

    public int getLine() {
	return yyline + 1;
    }

    public String getText() {
	return yytext();
    }
%}


nl = [\n\r]

cc = [\b\f]|{nl}

ws = ({cc}|[\t" "])

special = [\"\\t\"] | [\"\\n\"] | [\\]

num = [0-9]

linecomment = "//".*

binary = #b[01]+
hex = #x[0-9a-fA-F]+
charlit = '([^'])' | '\\?{special}'
uni = #u[0-9a-fA-F]{4}


%%

<YYINITIAL>	{nl}	{
                        //skip newline, but reset char counter
			yychar = 0;
			}

<YYINITIAL>    {linecomment}  { // ignore line comments
                      }

<YYINITIAL> "/*" {
						yybegin(YYCOMMENT);
}

<YYINITIAL>  \" {
							yybegin(STRING);
						}
						
<YYINITIAL>	{ws}	{/* ignore whitespace */}
<YYINITIAL>	{ws}"+"{ws}	{return new Symbol(sym.PLUS);}
<YYINITIAL>	{ws}"-"{ws}	{return new Symbol(sym.MINUS);}
<YYINITIAL>	{ws}"*"{ws}	{return new Symbol(sym.MUL);}
<YYINITIAL>	{ws}"/"{ws}	{return new Symbol(sym.DIV);}
<YYINITIAL>	{ws}"%"{ws}	{return new Symbol(sym.MOD);}
<YYINITIAL>	{ws}"^"{ws}	{return new Symbol(sym.POW);}
<YYINITIAL>	{ws}"@"{ws}	{return new Symbol(sym.CONCAT);}
<YYINITIAL>	{ws}"|"{ws}	{return new Symbol(sym.BITOR);}
<YYINITIAL>	{ws}"&"{ws}	{return new Symbol(sym.BITAND);}
<YYINITIAL>	"~"	{return new Symbol(sym.BITNOT);}
<YYINITIAL>	":="	{return new Symbol(sym.ASSIGN);}
<YYINITIAL>	":"{ws}	{return new Symbol(sym.COLON);}

<YYINITIAL>	"("	{return new Symbol(sym.LPAREN);}
<YYINITIAL>	")"	{return new Symbol(sym.RPAREN);}
<YYINITIAL>	"{"	{return new Symbol(sym.LBRACE);}
<YYINITIAL>	"}"	{return new Symbol(sym.RBRACE);}
<YYINITIAL> "["	{return new Symbol(sym.LSQUARE);}
<YYINITIAL> "]"	{return new Symbol(sym.RSQUARE);}
<YYINITIAL> "[:"	{return new Symbol(sym.LVECTOR);}
<YYINITIAL> ":]"	{return new Symbol(sym.RVECTOR);}

<YYINITIAL>	";"	{return new Symbol(sym.SEMI);}
<YYINITIAL>	","	{return new Symbol(sym.COMMA);}

<YYINITIAL>	"def"	{return new Symbol(sym.DEF);}
<YYINITIAL>	"proc"	{return new Symbol(sym.PROC);}
<YYINITIAL>	"lazy"	{return new Symbol(sym.LAZY);}
<YYINITIAL>	"name"	{return new Symbol(sym.NAME);}
<YYINITIAL> "call"	{return new Symbol(sym.CALL);}

<YYINITIAL>	"list"	{return new Symbol(sym.LIST);}

<YYINITIAL>    {binary}|{hex} { return new Symbol(sym.BINHEX, yytext()); }
<YYINITIAL>    read { return new Symbol(sym.READ); }
<YYINITIAL>    readint { return new Symbol(sym.READINT); }
<YYINITIAL>    print { return new Symbol(sym.PRINT); }
<YYINITIAL>    println { return new Symbol(sym.PRINTLN); }


<YYINITIAL>	{ws}"or"{ws}	{return new Symbol(sym.LOGOR);}
<YYINITIAL>	{ws}"and"{ws}	{return new Symbol(sym.LOGAND);}
<YYINITIAL>	"not"	{return new Symbol(sym.LOGNOT);}

<YYINITIAL>	"if"	{return new Symbol(sym.IF);}
<YYINITIAL>	"then"	{return new Symbol(sym.THEN);}
<YYINITIAL>	"else"	{return new Symbol(sym.ELSE);}
<YYINITIAL>	{ws}"or"{ws}	{return new Symbol(sym.LOGOR);}
<YYINITIAL>	{ws}"and"{ws}	{return new Symbol(sym.LOGAND);}
<YYINITIAL>	"not"	{return new Symbol(sym.LOGNOT);}
<YYINITIAL> "case"	{return new Symbol(sym.CASE);}

<YYINITIAL>	"for"	{return new Symbol(sym.FOR);}
<YYINITIAL>	"to"	{return new Symbol(sym.TO);}
<YYINITIAL>	"do"	{return new Symbol(sym.DO);}
<YYINITIAL>	"while"	{return new Symbol(sym.WHILE);}
<YYINITIAL>	"repeat"	{return new Symbol(sym.REPEAT);}
<YYINITIAL>	"until"	{return new Symbol(sym.UNTIL);}

<YYINITIAL>	"let"	{return new Symbol(sym.LET);}

<YYINITIAL>	{ws}"="{ws}	{return new Symbol(sym.EQUAL);}
<YYINITIAL>	{ws}"<"{ws}	{return new Symbol(sym.COMPARE, "<");}
<YYINITIAL>	{ws}"<="{ws}	{return new Symbol(sym.COMPARE, "<=");}
<YYINITIAL>	{ws}">"{ws}	{return new Symbol(sym.COMPARE, ">");}
<YYINITIAL>	{ws}">="{ws}	{return new Symbol(sym.COMPARE, ">=");}
<YYINITIAL>	"#t"	{return new Symbol(sym.BOOLEAN, new Boolean(true));}
<YYINITIAL>	"#f"	{return new Symbol(sym.BOOLEAN, new Boolean(false));}
<YYINITIAL>	"#e"	{return new Symbol(sym.EMPTY);}

<YYINITIAL>    {num}+ { return new Symbol(sym.INTEGER, new Integer(yytext())); }
<YYINITIAL>    "-"{num}+ 	{return new Symbol(sym.INTEGER, new Integer(yytext()));}
<YYINITIAL>		{num}*({num}"."|"."{num}){num}*		{return new Symbol(sym.DOUBLE, new Double(yytext()));}
<YYINITIAL>		"-"{num}*({num}"."|"."{num}){num}*	{return new Symbol(sym.DOUBLE, new Double(yytext()));}

<YYINITIAL>    {charlit}|{uni} { return new Symbol(sym.CHAR, yytext()); }

<YYINITIAL>	([a-zA-Z0-9]|"+"|"-"|"/"|"*"|"!"|"@"|"$"|"%"|"^"|"&"|"_"|"="|"|"|"?"|"<"|">"|"."|"~"|"`")*([a-zA-Z]|"+"|"-"|"/"|"*"|"!"|"@"|"$"|"%"|"^"|"&"|"_"|"="|"|"|"?"|"<"|">"|"~"|"`"|"#")+([a-zA-Z0-9]|"+"|"-"|"/"|"*"|"!"|"@"|"$"|"%"|"^"|"&"|"_"|"="|"|"|"?"|"<"|">"|"."|"~"|"`"|"#")*	{return new Symbol(sym.VARIABLE, yytext());}
<YYINITIAL>    .        {
               // get here only if symbol has no matching rule
               // DO NOT add any rules below this one
               throw new TokenException(yytext());
               }
               
<STRING>	\" {
	yybegin(YYINITIAL);
}

<STRING> [^\"]* {
	// constant string
	// System.out.println(yytext());
	return new Symbol(sym.STRING, yytext());
		}

<YYCOMMENT>  .|{nl} { // ignore block comments
							 }

<YYCOMMENT> "*/" {
	yybegin(YYINITIAL);
}


