import { QuestionData } from "./question-data.model"
import { Quiz } from "./quiz-data.model"

export interface QuizSetData {
  quizz: Quiz,
  questions: QuestionData []
};
