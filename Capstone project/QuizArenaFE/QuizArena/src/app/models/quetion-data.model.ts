export interface Question {
  questionId?: number;
  questionText?: string;
  difficultyLevel?: number;
  correctAnswer?: number;
  optionsSRC002?:string [];
  status?: number;
  userId?: number
}
