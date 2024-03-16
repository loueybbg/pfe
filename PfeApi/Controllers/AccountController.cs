using Azure.Core;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PfeApi.Dtos.Account;
using PfeApi.Models;
using PfeApi.Services;

namespace PfeApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly ITokenService _tokenService;
        private readonly SignInManager<AppUser> _signinManager;
        public AccountController(UserManager<AppUser> userManager, ITokenService tokenService, SignInManager<AppUser> signInManager)
        {
            _userManager = userManager;
            _tokenService = tokenService;
            _signinManager = signInManager;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto loginDto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var user = await _userManager.Users.FirstOrDefaultAsync(x => x.Email == loginDto.Email.ToLower());

            if (user == null) return Unauthorized("Invalid username!");

            var result = await _signinManager.CheckPasswordSignInAsync(user, loginDto.Password, false);

            if (!result.Succeeded) return Unauthorized("Username not found and/or password incorrect");
            var roles = await _userManager.GetRolesAsync(user);
            var role = roles.FirstOrDefault();
            var userData = new NewUserDto
            {
                Username = user.UserName,
                Email = user.Email,
                Role = role
            };
            var accessToken = _tokenService.CreateToken(user);

            return Ok(
                new 
                {
                    Token = accessToken,
                    User = userData,
                    avatar = "avatar-s-11.jpg"

                }
            );
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var appUser = new AppUser
                {
                    UserName = registerDto.Username,
                    Email = registerDto.Email,
                    FullName = registerDto.FullName,
                    PhoneNumber = registerDto.PhoneNumber
                };

                var createdUser = await _userManager.CreateAsync(appUser, registerDto.Password);
                var userData = new NewUserDto
                {
                    Username = appUser.UserName,
                    Email = appUser.Email,
                    FullName = appUser.FullName,
                    Role = "User"
                };
                var accessToken = _tokenService.CreateToken(appUser);

                if (createdUser.Succeeded)
                {
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "User");
                    if (roleResult.Succeeded)
                    {
                        return Ok(
                            new
                            {
                                Token = accessToken,
                                User = userData,
                               // avatar = "avatar-s-11.jpg"
                            }
                        );
                    }
                    else
                    {
                        return StatusCode(500, roleResult.Errors);
                    }
                }
                else
                {
                    return StatusCode(500, createdUser.Errors);
                }
            }
            catch (Exception e)
            {
                return StatusCode(500, e);
            }
        }

        // GET: api/Account/users
        [HttpGet("users")]
        public async Task<IActionResult> GetUsers()
        {
            var users = await _userManager.Users.ToListAsync();

            var userDtos = new List<object>();

            foreach (var user in users)
            {
                var roles = await _userManager.GetRolesAsync(user);
                var userDto = new 
                {
                    Id = user.Id,
                    Username = user.UserName,
                    Email = user.Email,
                    FullName = user.FullName,
                    Role = roles.FirstOrDefault() // This will get the first role if there are multiple
                };
                userDtos.Add(userDto);
            }

            return Ok(userDtos);
        }

        // PUT: api/Account/changeRole/{id}
        [HttpPut("changeRole/{id}")]
        public async Task<IActionResult> ChangeRole(string id, [FromBody] string role)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            var roles = await _userManager.GetRolesAsync(user);
            await _userManager.RemoveFromRolesAsync(user, roles);

            var result = await _userManager.AddToRoleAsync(user, role);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            return NoContent();
        }

        // POST: api/Account/addUser
        [HttpPost("addUser")]
        public async Task<IActionResult> AddUser([FromBody] RegisterDto registerDto)
        {
            var appUser = new AppUser
            {
                UserName = registerDto.Username,
                Email = registerDto.Email,
                FullName = registerDto.FullName,
                PhoneNumber = registerDto.PhoneNumber
            };

            var createdUser = await _userManager.CreateAsync(appUser, registerDto.Password);
            if (!createdUser.Succeeded)
            {
                return BadRequest(createdUser.Errors);
            }

            return CreatedAtAction(nameof(GetUsers), new { id = appUser.Id }, appUser);
        }
    }
}

