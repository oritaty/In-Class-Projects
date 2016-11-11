#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#define MAX_NUMBER_OF_PROBLEMS 17
#define MIN_NUMBER_OF_PROBLEMS 8
#define MULTIPLE_CHOICE_ANSWERS 4
#define TRUE_OR_FALSE_ANSWERS 2

struct Problem {
	char* question;
	char** answers;
	int key_index;
	bool is_mult_choice;
};

const char* messages[] = {"Invalid input.", "Correct!!", "Incorrect."};
struct Problem problems[MAX_NUMBER_OF_PROBLEMS];

bool check_answer(struct Problem p){
	printf("Input your answer here: ");
	int user_input;
	scanf("%d", &user_input);
	int len = MULTIPLE_CHOICE_ANSWERS;
	if(!p.is_mult_choice) {
		len = TRUE_OR_FALSE_ANSWERS;
	} 
	bool rtn = false;
	if (user_input < -1 || user_input > len) {
		printf("%s\n", messages[0]);
	} else if (user_input == p.key_index || p.key_index == -1) {
		rtn = true;
		printf("%s\n", messages[1]);
	} else {
		printf("%s\nCorrect answer displayed: %s\n", messages[2], p.answers[p.key_index]);
	}
	return rtn;
}

void display_question(struct Problem p) {
	int i, len = MULTIPLE_CHOICE_ANSWERS;
	if(!p.is_mult_choice) {
		len = TRUE_OR_FALSE_ANSWERS;
	}
	printf("%s\n", p.question);  
	for (i = 0; i < len; i++) {
		printf("%d, %s\n", i, p.answers[i]);
	}
}

int main() {
	struct Problem prob1;
	char *ans1[TRUE_OR_FALSE_ANSWERS] = {"Yes", "No"};
	prob1.question = "Are you still alive?";
	prob1.answers = ans1;
	prob1.key_index = 0;
	assert(prob1.key_index >= -1 && prob1.key_index < TRUE_OR_FALSE_ANSWERS);
	prob1.is_mult_choice = false;
	problems[0] = prob1;
	
	struct Problem prob2;
	char *ans2[TRUE_OR_FALSE_ANSWERS] = {"Yes", "No"};
	prob2.question = "Are you in class?";
	prob2.answers = ans2;
	prob2.key_index = 0;
	assert(prob2.key_index >= -1 && prob2.key_index < TRUE_OR_FALSE_ANSWERS);
	prob2.is_mult_choice = false;
	problems[1] = prob2;
	
	struct Problem prob3;
	char *ans3[MULTIPLE_CHOICE_ANSWERS] = {"Money", "Excitement", "Stability", "Other"};
	prob3.question = "What are you looking into the most in your career?";
	prob3.answers = ans3;
	prob3.key_index = -1; //key_index: -1 is used for problem without incorrect answers.
	assert(prob3.key_index >= -1 && prob3.key_index < MULTIPLE_CHOICE_ANSWERS);
	prob3.is_mult_choice = true;
	problems[2] = prob3;
	
	struct Problem prob4;
	char *ans4[MULTIPLE_CHOICE_ANSWERS] = {"Well-done", "Medium", "Rare", "I'm a vegetarian"};
	prob4.question = "How would you like your steak?";
	prob4.answers = ans4;
	prob4.key_index = -1;
	assert(prob4.key_index >= -1 && prob4.key_index < MULTIPLE_CHOICE_ANSWERS);
	prob4.is_mult_choice = true;
	problems[3] = prob4;
	
	int i = 0, crrct_cnt = 0;
	while (problems[i].question != NULL) {
		display_question(problems[i]);
		if (check_answer(problems[i])) {
			crrct_cnt++;
		}
		printf("Your total score: %d/%d\n", crrct_cnt, (i + 1));
		i++;
	}
	printf("Program ends here.\n");
	return 0;
}
