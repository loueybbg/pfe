﻿using Microsoft.AspNetCore.Identity;

namespace PfeApi.Models
{
    public class AppUser : IdentityUser
    {
        public string? FullName { get; set; }
        public int? PhoneNumber { get; set; }
    }
}