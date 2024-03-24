﻿using System.ComponentModel.DataAnnotations;

namespace PfeApi.Dtos.Account
{
    public class AdminAddUserDto
    {
        [Required]
        public string? Username { get; set; }
        [Required]
        [EmailAddress]
        public string? Email { get; set; }
        [Required]
        public string? Password { get; set; }
        public string? FullName { get; set; }
        public int? PhoneNumber { get; set; }
        public string Role { get; set; }
    }
}