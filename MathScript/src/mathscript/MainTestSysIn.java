/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mathscript;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import mathscript.elements.Expression;
import mathscript.parser.ExpressionParser;
import mathscript.parser.Tokenizer;

/**
 *
 * @author ccwelich
 */
public class MainTestSysIn {

	/**
	 * @param args the command line arguments
	 */
	public static void main(String[] args) {
		ExpressionParser parser = new ExpressionParser();
		int raw = 0;
		BufferedReader r = new BufferedReader(new InputStreamReader(System.in));
		try {
			do {
				
				raw = r.read();
				System.out.println("read: "+raw+", "+(char)raw);

			} while (raw != -1);
		} catch (Exception ex) {
			if (ex instanceof ParseException) {
				ParseException t = (ParseException) ex;
				System.err.println("offset: " + t.getErrorOffset());
			}
			ex.printStackTrace();
		}
	}
}
