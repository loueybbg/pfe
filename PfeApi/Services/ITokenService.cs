using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using PfeApi.Models;

using PfeApi.Models;

namespace PfeApi.Services
{
    public interface ITokenService
    {
        string CreateToken(AppUser user);
    }
}
