/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mathscript;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.ParseException;
import mathscript.elements.Expression;
import mathscript.parser.ExpressionParser;
import mathscript.parser.Tokenizer;

/**
 *
 * @author ccwelich
 */
public class Main {

	/**
	 * @param args the command line arguments
	 */
	public static void main(String[] args) {
		ExpressionParser parser = new ExpressionParser();

		Tokenizer tok = null;
		try {
			do {
				System.out.print(">> ");
				Expression exp = null;
				BufferedReader r = new BufferedReader(new InputStreamReader(System.in));
				tok = new Tokenizer(r);
				exp = parser.parse(tok);

				if (exp == null) {
					System.exit(0);
				}
				System.out.println(exp);
				System.out.println(exp.toDouble());

			} while (true);
		} catch (Exception ex) {
			if (ex instanceof ParseException) {
				ParseException t = (ParseException) ex;
				System.err.println("offset: " + t.getErrorOffset());
			}
			ex.printStackTrace();
		}
	}
}
