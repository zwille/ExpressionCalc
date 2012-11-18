package mathscript.parser;

import java.io.IOException;
import java.text.ParseException;
import mathscript.elements.*;
import mathscript.symbols.Op;
import mathscript.types.R;
import mathscript.types.Z;

public class ExpressionParser {

	Tokenizer tok;

	public Expression parse(Tokenizer tok) throws IOException, ParseException {
		this.tok = tok;
		Expression expression = null;
//		System.out.println("parse init token="+tok.tokenType()+", "+tok.previewToken());
		if(tok.tokenType()==TokenType.EOF)
			return null;
		if(tok.tokenType()==TokenType.WORD && tok.previewToken().equals("exit"))
			return null;
		try {
			expression = parseExpression();
		} catch (NumberFormatException exc) {
			throw new ParseException("illegal number format", tok.getIndex());
		}
		if(tok.tokenType()!=TokenType.EOL)
			throw new ParseException("expected end of line", tok.getIndex());
//		System.out.println("parse:: leave, token = " +tok.previewToken()+", type = "+tok.tokenType());
		return expression;
	}

	public Expression parseExpression() throws IOException, ParseException, NumberFormatException {
		Expression expression = new Expression();
//		System.out.println("parseExpression:: init, token = "+tok.previewToken());
		byte sign = 1;
		if (isSumOperator()) {
			sign = getSign();
		}
		expression.add(parseProduct(sign));
		while (isSumOperator()) {
			sign = getSign();
			expression.add(parseProduct(sign));
		}
		return expression;
	}
	// <Product> ::= <Factor> { <opProduct> <Factor> } 	

	private Product parseProduct(byte sign) throws NumberFormatException, IOException, ParseException {
		Product product = new Product(sign);
		byte signOfExponent = 1;
		product.add(parseFactor(signOfExponent));
		
		while (isProductOperator()) {
//			System.out.println("parseProduct:: isProductOperator true");
			signOfExponent = getSignOfExponent();
			product.add(parseFactor(signOfExponent));
		}
		return product;
	}
	// <Factor> ::= <Literal> [ <opExponent> <Literal> ]

	private Factor parseFactor(byte signOfExponent) throws NumberFormatException, IOException, ParseException {
		Factor factor = new Factor(signOfExponent);
		factor.add(parseLiteral());
		while (isExponentOperator()) {
//			System.out.println("parseFactor is exp");
			tok.nextToken();
			factor.add(parseLiteral());
		}
		return factor;
	}

	private boolean isSumOperator() {
		if (tok.tokenType() != TokenType.SPECIAL) {
			return false;
		}
		String token = tok.previewToken().toString();
		return Op.PLUS.getSymbol().equals(token) || Op.MINUS.getSymbol().equals(token);
	}

	private byte getSign() throws IOException {
		String token = tok.nextToken().toString();
		if (Op.MINUS.getSymbol().equals(token)) {
//			System.out.println("getSign -");
			return -1;
		}
		assert Op.PLUS.getSymbol().equals(token);
//		System.out.println("getSign +");
		return 1;
	}


	private boolean isProductOperator() {
		if (tok.tokenType() != TokenType.SPECIAL) {
			return false;
		}
		String token = tok.previewToken().toString();
		return Op.MUL.getSymbol().equals(token) || Op.DIV.getSymbol().equals(token);
	}

	private byte getSignOfExponent() throws IOException {
		String token = tok.nextToken().toString();
		if (Op.DIV.getSymbol().equals(token)) {
			return -1;
		}
		assert Op.MUL.getSymbol().equals(token);
		return 1;
	}
	// <Literal> ::= ( <Number>  | '(' <Expression ')' // | <Symbol>) // [ <PostFix> ]

	private Literal parseLiteral() throws IOException, ParseException {
		String token = tok.previewToken().toString();
//		System.out.println("parseLiteral:: before parsing: token = "+token);
		if (tok.tokenType()==TokenType.SPECIAL && Op.LEFT_BRACE.getSymbol().equals(token)) {
			tok.nextToken();
//			System.out.println("parseLiteral:: found expression: token ="+token);	
			Expression expression = parseExpression();
			token = tok.nextToken().toString();
			if (!Op.RIGHT_BRACE.getSymbol().equals(token)) {
				throw new ParseException(" " + Op.RIGHT_BRACE.getSymbol() + " expected", tok.getIndex());
			}
			return new Literal(expression);
		}
		if(tok.tokenType()==TokenType.WORD) {
			token = tok.nextToken().toString();
			Literal rc = getConstant(token);
			if(rc!=null)
				return rc;
		}
		return new Literal(parseNumber());
	}

	private boolean isExponentOperator() {
		if (tok.tokenType() != TokenType.SPECIAL) {
			return false;
		}
		String token = tok.previewToken().toString();
		String op = Op.EXP.getSymbol();
		return op.equals(token);
	}
	// <Number>	::= <Decimal> | <Integer>

	private mathscript.elements.Number parseNumber() throws NumberFormatException, IOException, ParseException {
		final TokenType tokenType = tok.tokenType();
		final int index = tok.getIndex();
		final Object token = tok.nextToken();
//		System.out.println("parseNumber:: token = "+token+", type = "+tokenType);
//		System.out.println("parseNumber:: leave, token = "+tok.previewToken()+", type = "+tok.tokenType());
		switch (tokenType) {
			case DECIMAL:
				return new R((Double) token);
			case INTEGER:
				return new Z((Integer) token);
			default:
				throw new ParseException("number expected", index);
		}
		
	}

	private Literal getConstant(String token) {
		switch(token) {
			case "pi":
				return new Literal(Constant.PI);
			case "e":
				return new Literal(Constant.E);
			default:
				return null;
		}
	}
}
