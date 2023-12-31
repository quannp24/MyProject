namespace QuizArenaBE.Entity.Validation
{
    public static class ValidationMessages
    {
        public const string UsernameRequired = "Username is required.";
        public const string UsernameMinLength = "Username must be at least 6 characters.";
        public const string PasswordRequired = "Password is required.";
        public const string PasswordMinLength = "Password must be at least 6 characters.";
        public const string PasswordComplexityRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$";
        public const string PasswordComplexity = "Password must contain at least one uppercase letter and one digit.";
        public const string EmailRequired = "Email is required.";
        public const string EmailFormat = "Invalid email format.";
        
    }
}
