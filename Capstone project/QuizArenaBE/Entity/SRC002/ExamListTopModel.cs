namespace QuizArenaBE.Entity.SRC002
{
    public class ExamListTopModel
    {
        public string examId { get; set; }

        public string? examName { get; set; }

        public string? description { get; set; }

        public int? exam_type { get; set; }

        public int? status { get; set; }

        public string? image { get; set; }

        public DateTime? date { get; set; }

        public int? time_limit { get; set; }

        public int? CountQuestion { get; set; }

        public int? NumberUserJoin { get; set; }
    }
}
