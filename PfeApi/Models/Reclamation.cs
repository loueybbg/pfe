namespace PfeApi.Models
{
    public class Reclamation
    {
        public IFormFile File { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Author { get; set; }
        public string ownerId { get; set; }
        public string contentType { get; set; }

    }
}
