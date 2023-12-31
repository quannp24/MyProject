namespace QuizArenaBE.Entity.SRC002
{
    public class QuizByStatusResponse
    {
        public List<QuizStatus0>? QuizzesStatus0 { get; set; }
        public List<QuizStatus1>? QuizzesStatus1 { get; set; }
        public List<QuizStatus2>? QuizzesStatus2 { get; set; }
    }

    public class QuizStatus0
    {
        public int? QuizId { get; set; }
        public string? Title { get; set; }
        public int? CategoryId { get; set; }
        public string? Description { get; set; }
        public int? QuizType { get; set; }
        public int? Status { get; set; }
        public string? Image { get; set; }
        public int? DifficultyLevel { get; set; }
        public int? TimeLimit { get; set; }
        public int? CreatorId { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? Role { get; set; }
    }

    public class QuizStatus1
    {
        public int? QuizId { get; set; }
        public string? Title { get; set; }
        public int? CategoryId { get; set; }
        public string? Description { get; set; }
        public int? QuizType { get; set; }
        public int? Status { get; set; }
        public string? Image { get; set; }
        public int? DifficultyLevel { get; set; }
        public int? TimeLimit { get; set; }
        public int? CreatorId { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? Role { get; set; }
    }

    public class QuizStatus2
    {
        public int? QuizId { get; set; }
        public string? Title { get; set; }
        public int? CategoryId { get; set; }
        public string? Description { get; set; }
        public int? QuizType { get; set; }
        public int? Status { get; set; }
        public string? Image { get; set; }
        public int? DifficultyLevel { get; set; }
        public int? TimeLimit { get; set; }
        public int? CreatorId { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? Role { get; set; }
    }
    public class QuizStaff
    {
        public int? QuizId { get; set; }
        public string? Title { get; set; }
        public int? CategoryId { get; set; }
        public string? Description { get; set; }
        public int? QuizType { get; set; }
        public int? Status { get; set; }
        public string? Image { get; set; }
        public int? DifficultyLevel { get; set; }
        public int? TimeLimit { get; set; }
        public int? CreatorId { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? Role { get; set; }
    }
}
