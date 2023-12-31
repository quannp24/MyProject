namespace QuizArenaBE.Entity.SRC002
{
    public class QuizA
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

        // Thêm các thuộc tính liên quan đến User
        public int? CreatorUserId { get; set; }
        public string? CreatorUsername { get; set; }
        public string? CreatorFullName { get; set; }
    }
}
