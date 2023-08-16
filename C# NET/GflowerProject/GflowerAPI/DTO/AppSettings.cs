namespace GflowerAPI.DTO
{
    public class AppSettings
    {
        public string Secret { get; set; }

        public AppSettings(string key) {
            this.Secret = key;
        }

        public AppSettings() { }
    }
}
