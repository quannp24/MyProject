namespace QuizArenaBE.Entity.SRC002
{
    public class ChangeQuestionStatusRequest
    {
        public int QuestionId { get; set; }
        public int NewStatus { get; set; }
    }
}
