namespace QuizArenaBE.Entity.SRC002
{
    public class GetInforChallengeModel
    {
        public ExamInfo examInfo { get; set; }

        public List<Ranking> ranking { get; set; }
        public MyRanking? myRanking { get; set; }

        public class ExamInfo
        {
            public string? examName { get; set; }

            public int? examType { get; set; }


            public string? Image { get; set; }         

            public DateTime? date { get; set; }

            public int? status { get; set; }

            public int? timeLimit { get; set; }

            public int? NumberQuestion { get; set; }

            public int? NumberUser { get; set; }
        }
        public class Ranking
        {
            public int UserId { get; set; }

            public string? Username { get; set; }

            public string? Fullname { get; set; }
            public string? Images { get; set; }

            public int? Score { get; set; }

            public DateTime? timeSubmit { get; set; }
            public int? positionRank { get; set; }
        }
        public class MyRanking
        {
            public int? Score { get; set; }

            public DateTime? timeSubmit { get; set; }

            public int? positionRank { get; set; }
        }

    }
}
