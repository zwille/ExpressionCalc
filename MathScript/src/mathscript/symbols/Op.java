/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mathscript.symbols;

/**
 *
 * @author ccwelich
 */
public enum Op {
	PLUS("+"),
	MINUS("-"),
	MUL("*"),
	DIV("/"),
	EQUALS("="),
	NOT_EQUALS("!="),
	LOWER("<"),
	LOWER_OR_EQUAL("<="),
	GREATER(">"),
	GREATER_OR_EQUAL(">="),
	NOT("!"),
	EXP("^"),
	LEFT_BRACE("("),
	RIGHT_BRACE(")");
	String symbol;

	private Op(String symbol) {
		this.symbol = symbol;
	}

	public String getSymbol() {
		return symbol;
	}
}
