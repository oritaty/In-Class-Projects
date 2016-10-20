class Problem {
	final String[] mssgs = { "Invalid input.", "Correct!!", "Incorrect." };
	private String question;
	private String[] answers;
	private int keyindex;

	public Problem(String question, String[] answers, int keyindex) {
		//keyindex -1 may be used for problem without incorrect answers.
		assert (answers.length >= keyindex && keyindex >= -1);
		this.question = question;
		this.answers = answers;
		this.keyindex = keyindex;
	}

	public String getQuestion() {
		return this.question;
	}

	public String[] getAnswers() {
		return this.answers;
	}

	public int getKeyIndex() {
		return this.keyindex;
	}

	public void displayQuestion() {
		String str = getQuestion() + "\n";
		for (int i = 0; i < getAnswers().length; i++){
			str += i + ": " + answers[i] + "\n";
		}
		str += "Enter your answer:";
		System.out.println(str);
	}

	// How do I prompt the user input from Altera board?
	public boolean checkAnswer(int userInput) {
		boolean rtn = false;
		if (userInput < -1 || userInput > getAnswers().length) {
			System.out.println(mssgs[0]);
		} else if (userInput == getKeyIndex()) {
			System.out.println(mssgs[1]);
			rtn = true;
		} else {
			System.out.printf("%s\nCorrect answer displayed: %s\n", mssgs[2],
					answers[getKeyIndex()]);
		}
		return rtn;
	}
}
