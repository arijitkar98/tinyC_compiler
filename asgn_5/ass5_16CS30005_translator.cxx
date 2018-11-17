#include "ass5_16CS30005_translator.h"
#include "y.tab.h"

int size_int=4;
int size_float=8;
int size_pointer=4;
int size_char=1;
int size_bool=1;

type_n *glob_type;
int glob_width;
int next_instr;
int temp_count=0;
symtab *glob_st =new symtab();
symtab *curr_st = new symtab();
quad_arr glob_quad;

type_n::type_n(types t,int sz,type_n *n)
{
	basetp=t;
	size=sz;
	next=n;
}

int type_n::getSize()
{
	if(this==NULL)
		return 0;
	//return the size of the array by calling the recursive function
	//here we are not checking for null as if it will reach the final type it will enter the below conditions
	if((this->basetp) == tp_arr)
		return ((this->size)*(this->next->getSize()));
	if((this->basetp) == tp_void)
		return 0;
	if((this->basetp) == tp_int)
		return size_int;
	if((this->basetp) == tp_float)
		return size_float;
	if((this->basetp) == tp_bool)
		return size_bool;
	if((this->basetp) == tp_char)
		return size_char;
	if((this->basetp) == tp_ptr)
		return size_pointer;
}

types type_n::getBasetp()
{
	if(this!=NULL)
		return this->basetp;
	else
		return tp_void;
}

void type_n::printSize()
{
	printf("%d\n",size);
}

void type_n::print()
{
	switch(basetp){
		case tp_void:
			printf("Void");
			break;
		case tp_bool:
			printf("Bool");
			break;
		case tp_int:
			printf("Int");
			break;
		case tp_char:
			printf("Char");
			break;
		case tp_float:
			printf("Float");
			break;
		case tp_ptr:
			printf("ptr(");
			if(this->next!=NULL)
				this->next->print();
			printf(")");
			break;
		case tp_arr:
			printf("array(%d,",size);
			if(this->next!=NULL)
				this->next->print();
			printf(")");
			break;
		case tp_func:
			printf("Function()");
			break;
		default:
			printf("TYPE NOT FOUND\n");
			exit(-1);
	}

}

array::array(string s,int sz,types t)
{
	this->base_arr=s;
	this->tp=t;
	this->bsize=sz;
	this->dimension_size=1;
}

void array::addindex(int i)
{
	this->dimension_size=this->dimension_size+1;
	this->dims.push_back(i);
}

void funct::print()
{

	printf("Funct(");
	int i;
	for(i=0;i<typelist.size();i++)
	{
		if(i!=0)
			printf(",");
		printf("%d ",typelist[i]);
	}
	printf(")");
}

funct::funct(vector<types> tpls)
{
	typelist=tpls;
}
symdata::symdata(string n)
{
	name=n;
	size=0;
	tp_n=NULL;
	offset=-1;
	var_type="";
	isInitialized=false;
	isFunction=false;
	isArray=false;
	arr=NULL;
	fun=NULL;
	nest_tab=NULL;
}

void symdata::createarray()
{
	arr=new array(this->name,this->size,tp_arr);
}


symtab::symtab()
{
	name="";
	offset=0;
}

symtab::~symtab()
{
	int i;
	for(i=0;i<symbol_tab.size();i++)
	{
		type_n *p1=symbol_tab[i]->tp_n;
		type_n *p2;
		while(true)
		{
			if(p1 == NULL)
				break;
			p2=p1;
			p1=p1->next;
			delete p2;
		}
	}
}

type_n *CopyType(type_n *t)
{
	/*Duplicates the input type and returns the pointer to the newly created type*/
	if(t == NULL) return t;
	type_n *ret = new type_n(t->basetp);

	ret->size = t->size;
	ret->basetp = t->basetp;

	ret->next = CopyType(t->next);
	return ret;
}

symdata* symtab::lookup(string n)
{
	int i;
	for(i=0;i<symbol_tab.size();i++)
	{
		if(symbol_tab[i]->name == n)
		{
			return symbol_tab[i];
		}
	}
	symdata *temp_o=new symdata(n);
	temp_o->i_val.int_val=0;
	symbol_tab.push_back(temp_o);
	return symbol_tab[symbol_tab.size()-1];
}

symdata* symtab::search(string n)
{
	int i;
	for(i=0;i<symbol_tab.size();i++)
	{
		if(symbol_tab[i]->name==n)
		{
			return (symbol_tab[i]);
		}
	}
	return NULL;
}

symdata* symtab::gentemp(type_n *type)
{
	char c[10];
	sprintf(c,"t%03d",temp_count);
	temp_count++;
	symdata *temp=lookup(c);
	int temp_sz;
	if(type==NULL)
		temp_sz=0;
	else if((type->basetp) == tp_void)
		temp_sz=0;
	else if((type->basetp) == tp_int)
		temp_sz=size_int;
	else if((type->basetp) == tp_float)
		temp_sz=size_float;
	else if((type->basetp) == tp_bool)
		temp_sz=size_bool;
	else if((type->basetp) == tp_char)
		temp_sz=size_char;
	else if((type->basetp) == tp_ptr)
		temp_sz=size_pointer;
	else
		temp_sz=type->getSize();
	temp->size=temp_sz;
	temp->var_type="temp";
	temp->tp_n=type;
	this->offset=this->offset+(temp->size);
	return temp;
}

void symtab::update(symdata *sm,type_n *type,basic_val initval,symtab *next)
{
	sm->tp_n=CopyType(type);
	sm->i_val=initval;
	sm->nest_tab=next;
	int temp_sz;
	if(sm->tp_n==NULL)
		temp_sz=0;
	else if(((sm->tp_n)->basetp) == tp_void)
		temp_sz=0;
	else if(((sm->tp_n)->basetp) == tp_int)
		temp_sz=size_int;
	else if(((sm->tp_n)->basetp) == tp_float)
		temp_sz=size_float;
	else if(((sm->tp_n)->basetp) == tp_bool)
		temp_sz=size_bool;
	else if(((sm->tp_n)->basetp) == tp_char)
		temp_sz=size_char;
	else if(((sm->tp_n)->basetp) == tp_ptr)
		temp_sz=size_pointer;
	else
		temp_sz=sm->tp_n->getSize();
	sm->size=temp_sz;
	sm->offset=this->offset+(sm->size);
	sm->isInitialized=false;
}

void symtab::print()
{
	printf("\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
	printf("\nSymbol Table : %s\n",name.c_str());
	printf("\n-------------------------------------------------------------------------------------\n");
	printf("Name\tValue\t\tvar_type\tSize\tOffset\tType");
	printf("\n-------------------------------------------------------------------------------------\n");
    for(int i = 0; i<(symbol_tab).size(); i++)
    {
        symdata * t = symbol_tab[i];
        printf("%s\t",symbol_tab[i]->name.c_str());
        if(t->isInitialized)
        {
        	if((t->tp_n)->basetp == tp_char) printf("%c\t\t",(t->i_val).char_val);
        	else if((t->tp_n)->basetp == tp_int) printf("%d\t\t",(t->i_val).int_val);
        	else if((t->tp_n)->basetp == tp_float) printf("%lf\t",(t->i_val).float_val);
       	 	else printf("----\t\t");
      	}
      	else
      		printf("null\t\t");
        printf("%s\t",t->var_type.c_str());
        printf("\t%d\t%d\t",t->size,t->offset);
		if(t->var_type == "func")
			printf("ptr-to-St( %s )",t->nest_tab->name.c_str());

		if(t->tp_n != NULL)
			(t->tp_n)->print();
		printf("\n");
	}
	printf("\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");

}
list* makelist(int i)
{
	list *temp = (list*)malloc(sizeof(list));
	temp->index=i;
	temp->next=NULL;
	return temp;
}
list* merge(list *lt1,list *lt2)
{
	list *temp = (list*)malloc(sizeof(list));
	list *p1=temp;
	int flag=0;
	list *l1=lt1;
	list *l2=lt2;
	while(l1!=NULL)
	{
		flag=1;
		p1->index=l1->index;
		if(l1->next!=NULL)
		{
			p1->next=(list*)malloc(sizeof(list));
			p1=p1->next;
		}
		l1=l1->next;
	}
	while(l2!=NULL)
	{
		if(flag==1)
		{
			p1->next=(list*)malloc(sizeof(list));
			p1=p1->next;
			flag=0;
		}
		p1->index=l2->index;
		if(l2->next!=NULL)
		{
			p1->next=(list*)malloc(sizeof(list));
			p1=p1->next;
		}
		l2=l2->next;
	}
	p1->next=NULL;
	return temp;
}

quad::quad(opcode opc,string a1,string a2,string rs)
{
	this->op=opc;
	this->arg1=a1;
	this->result=rs;
	this->arg2=a2;
}

void quad::print_arg()
{
	printf("\t%s\t=\t%s\top\t%s\t",result.c_str(),arg1.c_str(),arg2.c_str());
}

quad_arr::quad_arr()
{
	next_instr=0;
}

void quad_arr::emit(opcode opc, string arg1, string arg2, string result)
{
	if(result.size()!=0)
	{
		quad new_elem(opc,arg1,arg2,result);
		arr.push_back(new_elem);
	}
	else if(arg2.size()!=0)
	{
		quad new_elem(opc,arg1,"",arg2);
		arr.push_back(new_elem);
	}
	else if(arg1.size()!=0)
	{
		quad new_elem(opc,"","",arg1);
		arr.push_back(new_elem);
	}
	else
	{
		quad new_elem(opc,"","","");
		arr.push_back(new_elem);
	}
	next_instr=next_instr+1;
}

void quad_arr::emit(opcode opc, int val, string operand)
{
	char str[20];
	sprintf(str, "%d", val);
	if(operand.size()==0)
	{
		quad new_quad(opc,"","",str);
		arr.push_back(new_quad);
	}
	else
	{
		quad new_quad(opc,str,"",operand);
		arr.push_back(new_quad);
	}
	next_instr=next_instr+1;
}

void quad_arr::emit(opcode opc, float val, string operand)
{
	char str[20];
	sprintf(str, "%lf", val);
	if(operand.size()==0)
	{
		quad new_quad(opc,"","",str);
		arr.push_back(new_quad);
	}
	else
	{
		quad new_quad(opc,str,"",operand);
		arr.push_back(new_quad);
	}
	next_instr=next_instr+1;
}

void quad_arr::emit(opcode opc, char val, string operand)
{
	char str[20];
	sprintf(str, "'%c'", val);
	if(operand.size()==0)
	{
		quad new_quad(opc,"","",str);
		arr.push_back(new_quad);
	}
	else
	{
		quad new_quad(opc,str,"",operand);
		arr.push_back(new_quad);
	}
	next_instr=next_instr+1;
}

void quad_arr::print()
{
		opcode op;
		string arg1;
		string arg2;
		string result;
	for(int i=0;i<next_instr;i++)
	{
		op=arr[i].op;
		arg1=arr[i].arg1;
		arg2=arr[i].arg2;
		result=arr[i].result;
		printf("%3d :\t",i);
		if(Q_PLUS<=op && op<=Q_NOT_EQUAL)
	    {
	        printf("%s",result.c_str());
	        printf("\t=\t");
	        printf("%s",arg1.c_str());
	        printf(" ");
	        switch(op)
	        {
	            case Q_PLUS:
	            	printf("+");
	            	break;
	            case Q_MINUS:
	            	printf("-");
	            	break;
	            case Q_MULT:
	            	printf("*");
	            	break;
	            case Q_DIVIDE:
	            	printf("/");
	            	break;
	            case Q_MODULO:
	            	printf("%%");
	            	break;
	            case Q_LEFT_OP:
	            	printf("<<");
	            	break;
	            case Q_RIGHT_OP:
	            	printf(">>");
	            	break;
	            case Q_XOR:
	            	printf("^");
	            	break;
	            case Q_AND:
	            	printf("&");
	            	break;
	            case Q_OR:
	            	printf("|");
	            	break;
	            case Q_LOG_AND:
	            	printf("&&");
	            	break;
	            case Q_LOG_OR:
	            	printf("||");
	            	break;
	            case Q_LESS:
	            	printf("<");
	            	break;
	            case Q_LESS_OR_EQUAL:
	            	printf("<=");
	            	break;
	            case Q_GREATER_OR_EQUAL:
	            	printf(">=");
	            	break;
	            case Q_GREATER:
	            	printf(">");
	            	break;
	            case Q_EQUAL:
	            	printf("==");
	            	break;
	            case Q_NOT_EQUAL:
	            	printf("!=");
	            	break;
	        }
	        printf(" ");
	       	printf("%s\n",arg2.c_str());
	    }
	    else if(Q_UNARY_MINUS<=op && op<=Q_ASSIGN)
	    {
	        printf("%s",result.c_str());
	        printf("\t=\t");
	        switch(op)
	        {

	            //Unary Assignment Instruction
	            case Q_UNARY_MINUS :
	            	printf("-");
	            	break;
	            case Q_UNARY_PLUS :
	            	printf("+");
	            	break;
	            case Q_COMPLEMENT :
	            	printf("~");
	            	break;
	            case Q_NOT :
	            	printf("!");
	            	break;
	            //Copy Assignment Instruction
	            case Q_ASSIGN :
	            	break;
	        }
	        printf("%s\n",arg1.c_str());
	    }
	    else if(op == Q_GOTO) {printf("goto ");printf("%s\n",result.c_str());}
	    else if(Q_IF_EQUAL<=op && op<=Q_IF_GREATER_OR_EQUAL)
	    {
	        printf("if  ");printf("%s",arg1.c_str());printf(" ");
	        switch(op)
	        {
	            //Conditional Jump
	            case   Q_IF_LESS :
	            	printf("<");
	            	break;
	            case   Q_IF_GREATER :
	            	printf(">");
	            	break;
	            case   Q_IF_LESS_OR_EQUAL :
	            	printf("<=");
	            	break;
	            case   Q_IF_GREATER_OR_EQUAL :
	            	printf(">=");
	            	break;
	            case   Q_IF_EQUAL :
	            	printf("==");
	            	break;
	            case   Q_IF_NOT_EQUAL :
	            	printf("!=");
	            	break;
	            case   Q_IF_EXPRESSION :
	            	printf("!= 0");
	            	break;
	            case   Q_IF_NOT_EXPRESSION :
	            	printf("== 0");
	            	break;
	        }
	        printf("%s",arg2.c_str());printf("\tgoto ");
	        printf("%s\n",result.c_str());
	    }
	    else if(Q_CHAR2INT<=op && op<=Q_float2INT)
	    {
	        printf("%s",result.c_str());printf("\t=\t");
	        switch(op)
	        {
	            case Q_CHAR2INT :
	            	printf(" Char2Int(");printf("%s",arg1.c_str());printf(")\n");
	            	break;
	            case Q_CHAR2float :
	            	printf(" Char2float(");printf("%s",arg1.c_str());printf(")\n");
	            	break;
	            case Q_INT2CHAR :
	            	printf(" Int2Char(");printf("%s",arg1.c_str());printf(")\n");
	            	break;
	            case Q_float2CHAR :
	            	printf(" float2Char(");printf("%s",arg1.c_str());printf(")\n");
	            	break;
	            case Q_INT2float :
	            	printf(" Int2float(");printf("%s",arg1.c_str());printf(")\n");
	            	break;
	            case Q_float2INT :
	            	printf(" float2Int(");printf("%s",arg1.c_str());printf(")\n");
	            	break;
	        }
	    }
	    else if(op == Q_PARAM)
	    {
	        printf("param\t");printf("%s\n",result.c_str());
	    }
	    else if(op == Q_CALL)
	    {
	        if(!result.c_str())
					printf("call %s, %s\n", arg1.c_str(), arg2.c_str());
				else
					printf("%s\t=\tcall %s, %s\n", result.c_str(), arg1.c_str(), arg2.c_str());
	    }
	    else if(op == Q_RETURN)
	    {
	        printf("return\t");printf("%s\n",result.c_str());
	    }
	    else if( op == Q_RINDEX)
	    {
	        printf("%s\t=\t%s[%s]\n", result.c_str(), arg1.c_str(), arg2.c_str());
	    }
	    else if(op == Q_LINDEX)
	    {
	        printf("%s[%s]\t=\t%s\n", result.c_str(), arg1.c_str(), arg2.c_str());
	    }
	    else if(op == Q_LDEREF)
	    {
	        printf("*%s\t=\t%s\n", result.c_str(), arg1.c_str());
	    }
	    else if(op == Q_RDEREF)
	    {
	    	printf("%s\t=\t* %s\n", result.c_str(), arg1.c_str());
	    }
	    else if(op == Q_ADDR)
	    {
	    	printf("%s\t=\t& %s\n", result.c_str(), arg1.c_str());
	    }
	}
}

void backpatch(list *l,int i)
{
	list *temp =l;
	list *temp2;
	char str[10];
	sprintf(str,"%d",i);
	while(temp!=NULL)
	{
		glob_quad.arr[temp->index].result = str;
		temp2=temp;
		temp=temp->next;
		free(temp2);
	}
}

void typecheck(expresn *e1,expresn *e2,bool isAssign)
{
	types type1,type2;
	type1=(e1->type)->basetp;
	type2=(e2->type)->basetp;
	if(type1==type2)
	{
		return;
	}
	if(!isAssign)
	{
		if(type1>type2)
		{
			symdata *temp = curr_st->gentemp(e1->type);
			if(type1 == tp_int && type2 == tp_char)
				glob_quad.emit(Q_CHAR2INT, e2->loc->name, temp->name);
			else if(type1 == tp_float && type2 == tp_int)
				glob_quad.emit(Q_INT2float, e2->loc->name, temp->name);
			e2->loc = temp;
			e2->type = temp->tp_n;
		}
		else
		{
			symdata *temp = curr_st->gentemp(e2->type);
			if(type2 == tp_int && type1 == tp_char)
				glob_quad.emit(Q_CHAR2INT, e1->loc->name, temp->name);
			else if(type2 == tp_float && type1 == tp_int)
				glob_quad.emit(Q_INT2float, e1->loc->name, temp->name);
			e1->loc = temp;
			e1->type = temp->tp_n;
		}
	}
	else
	{
		symdata *temp = curr_st->gentemp(e1->type);
		if(type1 == tp_int && type2 == tp_float)
			glob_quad.emit(Q_float2INT, e2->loc->name, temp->name);
		else if(type1 == tp_float && type2 == tp_int)
			glob_quad.emit(Q_INT2float, e2->loc->name, temp->name);
		else if(type1 == tp_char && type2 == tp_int)
			glob_quad.emit(Q_INT2CHAR, e2->loc->name, temp->name);
		else if(type1 == tp_int && type2 == tp_char)
			glob_quad.emit(Q_CHAR2INT, e2->loc->name, temp->name);
		else
		{
			printf("%s %s Types compatibility not defined\n",e1->loc->name.c_str(),e2->loc->name.c_str());
			exit(-1);
		}
		e2->loc = temp;
		e2->type = temp->tp_n;
	}
}

void print_list(list *root)
{
	int flag=0;
	while(root!=NULL)
	{
		printf("%d ",root->index);
		flag=1;
		root=root->next;
	}
	if(flag==0)
	{
		printf("Empty List\n");
	}
	else
	{
		printf("\n");
	}
}
void conv2Bool(expresn *e)
{
	if((e->type)->basetp!=tp_bool)
	{
		(e->type) = new type_n(tp_bool);
		e->falselist=makelist(next_instr);
		glob_quad.emit(Q_IF_EQUAL,e->loc->name,"0","-1");
		e->truelist = makelist(next_instr);
		glob_quad.emit(Q_GOTO,-1);
	}
}

int main()
{
	yyparse();
	glob_st->name="Global";
	printf("=====================================================================================");
	printf("\n\nGenerated Quads for the program\n\n");
	glob_quad.print();
	printf("=====================================================================================");
	printf("\n\nSymbol table Maintained For the Given Program\n");
	glob_st->print();
	for(int i=0; i<glob_st->symbol_tab.size();i++)
	{
		((glob_st->symbol_tab[i])->nest_tab)->print();
	}
	printf("=====================================================================================\n");
	return 0;
}
