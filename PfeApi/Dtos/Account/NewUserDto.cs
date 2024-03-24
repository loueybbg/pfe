using Microsoft.AspNetCore.Identity;

namespace PfeApi.Dtos.Account
{
    public class NewUserDto
    {
        public string Username { get; set; }
        public string Email { get; set; }
        //public string accessToken { get; set; }
        public string? Role { get; set; }
        public string? FullName { get; set; }
    }
}