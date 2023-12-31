export class ChallengeData {
  constructor(
    public examId: string,
    public examName: string,
    public quizId: number,
    public description?: string,
    public examType?: number,
    public image?: string,
    public status?: number,
    public date?: Date
  ) { }
};


