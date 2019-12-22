package fnplot.syntax;

import fnplot.semantics.Visitor;
import fnplot.sys.FnPlotException;

public class StmtPlot extends Statement{
    Exp plotfn;
    Exp lowerbound , upperbound;
    String var;


    public StmtPlot(Exp exp1, String var, Exp exp2, Exp exp3){
        this.plotfn = exp1;
        this.lowerbound = exp2;
        this.upperbound = exp3;
        this.var = var;
    }

    public <S, T> T visit(Visitor<S, T> v, S state) throws FnPlotException {
        return v.visitStmtPlot(this, state);
    }

    public Exp getExp(){
        return this.plotfn;
    }

    public Exp getLowerBound(){
        return this.lowerbound;
    }

    public Exp getUpperBound(){
        return this.upperbound;
    }

    public String getVar(){
        return this.var;
    }

    public String toString(){
        return "low priority, not done yet";
    }

}