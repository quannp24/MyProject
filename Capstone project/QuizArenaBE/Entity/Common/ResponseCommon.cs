namespace QuizArenaBE.Entity.Common
{
    public class ResponseCommon<T>
    {
        public ResponseCommon(T? result, string message = "", bool status = true)
        {
            Status = status;
            Message = message;
            Result = result;
            
        }

        public string Message { get; set; }

        public bool Status { get; set; }

        public T? Result { get; set; }


    }

    public class ResponseCommon
    {
        public ResponseCommon(string message = "", bool status = true)
        {
            Status = status;
            Message = message;

        }

        public string Message { get; set; }

        public bool Status { get; set; }

    }

    public class ResponseCommonInt
    {
        public ResponseCommonInt(string message = "", int status = 1)
        {
            Status = status;
            Message = message;
        }

        public string Message { get; set; }

        public int Status { get; set; }
    }

}
