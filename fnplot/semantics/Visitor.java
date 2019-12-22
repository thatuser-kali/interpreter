package fnplot.semantics;

import fnplot.syntax.Statement;
import fnplot.syntax.StmtDefinition;
import fnplot.syntax.StmtLet;
import fnplot.syntax.StmtSequence;
import fnplot.syntax.ExpDiv;
import fnplot.syntax.ExpLit;
import fnplot.syntax.ExpMul;
import fnplot.syntax.ExpSub;
import fnplot.syntax.ExpMod;
import fnplot.syntax.ExpVar;
import fnplot.syntax.ExpAdd;
import fnplot.syntax.ExpFunction;
import fnplot.syntax.StmtPlot;
import fnplot.syntax.ExpFunctionCall;
import fnplot.syntax.ArithProgram;
import fnplot.sys.FnPlotException;

/**
 * The generic Visitor interface for the Arithmetic parser
 * example.
 * @param <S> The type of the information needed by the visitor
 * @param <T> The type of result returned by the visitor 
 */
public interface Visitor<S, T> {

    // program
    public T visitArithProgram(ArithProgram p, S arg) throws FnPlotException;

    // statements

    /**
     * Visit a sequence of statements.
     * @param exp The statement sequence AST to be visited
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the given statement sequence.
     * @throws FnPlotException If an error arises while visiting the node.
     */
    public T visitStmtSequence(StmtSequence exp, S arg) throws FnPlotException ;

    /**
     * Visit an assignment (or definition) statement.
     * @param sd The assignment AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the given statement sequence.
     * @throws FnPlotException If an error arises while visiting the node.
     */
    public T visitStmtDefinition(StmtDefinition sd, S arg) throws FnPlotException;
    
    /**
     * Visit a let expression.
     * @param letExp The let AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitStmtLet(StmtLet letExp, S arg) throws FnPlotException;

    // expressions
    /**
     * Visit an add expression.
     * @param exp The addition AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpAdd(ExpAdd exp, S arg) throws FnPlotException ;
    
    /**
     * Visit a subtraction expression.
     * @param exp The subtraction AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpSub(ExpSub exp, S arg) throws FnPlotException;
    
    /**
     * Visit a multiplication expression.
     * @param exp The multiplication AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpMul(ExpMul exp, S arg) throws FnPlotException;
    
    /**
     * Visit a division expression.
     * @param exp The division AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpDiv(ExpDiv exp, S arg) throws FnPlotException;
    
    /**
     * Visit a modulo expression.
     * @param exp The modulo AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpMod(ExpMod exp, S arg) throws FnPlotException;
    
    /**
     * Visit a literal expression.
     * @param exp The literal AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpLit(ExpLit exp, S arg) throws FnPlotException;
    
    /**
     * Visit a variable reference expression.
     * @param exp The variable reference AST node to be visited.
     * @param arg The "state" to be referenced by this visitor while visiting 
     * the given node.
     * @return The result of visiting the subtree rooted at this node in the AST.
     * @throws FnPlotException If an error arises while visiting the subtree.
     */
    public T visitExpVar(ExpVar exp, S arg) throws FnPlotException;

    /**
     * Visit a function definition expression
     * 
     * 
     */

     public T visitfnDefn(ExpFunction exp, S arg ) throws FnPlotException;

     /**
      * Visit a function call expression 
      *
      */
      public T visitfnCall(ExpFunctionCall exp, S arg) throws FnPlotException;

      /**
       * Visit a plot statement expression
       * 
       */
       public T visitStmtPlot(StmtPlot plotExp, S arg) throws FnPlotException;


}
