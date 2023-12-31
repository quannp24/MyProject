
export interface InsertQuizReq {
    quizz: QuizzesSRC002Req;
    questions: QuestionsSRC002Req[];
  }
  
  export interface QuizzesSRC002Req {
    Title: string;
    CategoryId: number;
    Description: string;
    QuizType: number;
    DifficultyLevel: number;
    TimeLimit: number;
  }
  
  export interface QuestionsSRC002Req {
    QuestionId?: number;
    QuestionText: string;
    DifficultyLevel: number;
    CorrectAnswer: string;
    Options: string;
  }
  