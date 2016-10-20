import java.io.*;
import java.util.*;

class Main {
	public static void main(String[] args) throws IOException {
		List<Problem> pSet = new LinkedList<Problem>();
		Problem problem1 = new Problem("Are you still alive?", new String[] {
				"Yes", "No", "I don't know" }, 0);
		Problem problem2 = new Problem("Are you in class?", new String[] {
				"Yes", "No. Still in bed." }, 0);
		Problem problem3 = new Problem("This is 2016.", new String[] { "True",
				"False" }, 0);
		pSet.add(problem1);
		pSet.add(problem2);
		pSet.add(problem3);
		BufferedReader br = null;
		try {
			/*
			 * This is just for test purpose. In real project,
			 * input will be prompted through Altera board.
			 */
			br = new BufferedReader(new InputStreamReader(System.in));
			int index = 0, correct = 0, size = pSet.size();
			Problem target = null;
			while (index < size) {
				target = pSet.get(index);
				target.displayQuestion();
				String line = br.readLine();
				int input = Integer.parseInt(line);
				//System.out.println(input);
				if (target.checkAnswer(input)) {
					correct++;
				}
				System.out.println("Your current score: " + correct + "/" + (index + 1));
				index++;
			}
		} catch (IOException ioe) {
			System.err.println("Invalid input.\n" + ioe.getMessage());
		} catch (NumberFormatException nfe) {
			System.out.println("Can't resolve to integer.\n" + nfe.getMessage());
		} finally {
			br.close();
		}
	}
}
