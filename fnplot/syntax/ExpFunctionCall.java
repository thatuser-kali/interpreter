package fnplot.syntax;

import fnplot.semantics.Visitor;
import fnplot.sys.FnPlotException;
import java.util.ArrayList;

public class ExpFunctionCall extends Exp{
    ArrayList<Exp> arguments;
    Exp fn;


    public ExpFunctionCall(Exp fn , ArrayList<Exp> args){
        this.fn = fn;
        this.arguments = args;
    }

    public Exp getProc(){
        return this.fn;
    }

    public ArrayList<Exp> getArgs(){
        return this.arguments;
    }

    public int getArgsLength(){
        return this.arguments.size();
    }

    public <S, T> T visit(Visitor<S,T> v, S state ) throws FnPlotException{
        return v.visitfnCall(this, state);
    }

    public String toString(){
        return "Undefined toString Method, low priority";
    }
}