export interface Quiz {
  quizId?: number;
  title?: string;
  category?: string;
  categoryId?: number;
  description?: string;
  image?: string;
  isFriendCreator?:boolean;
  creatorId?:number;
  quizType?:number;
  status?:number;
  difficultyLevel?:number;
  timeLimit?:number;
  comment?:string;
  createDate?:Date,
  numberQues?:number
}
