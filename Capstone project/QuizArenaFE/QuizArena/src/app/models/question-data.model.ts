export interface QuestionData {
  questionId: number,
  questionText: string,
  difficultyLevel:number,
  correctAnswer : string,
  options:string,
  optionsSRC002?:string[],
  status?: number,
  userId?: number,
  username?: string
};
