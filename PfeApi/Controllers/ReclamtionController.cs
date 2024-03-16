using Azure.Core;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PfeApi.Models;
using System.Reflection.Metadata;

namespace PfeApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReclamtionController : ControllerBase
    {
        [HttpPost("upload")]
        public async Task<IActionResult> Upload([FromForm] Reclamation model)
        {
            if (model.File == null  && model.File.Length == 0)
            {
                return BadRequest("No file uploaded");
            }
            var folderName = Path.Combine("Resources","AllFiles");
            var PathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);
            if (!Directory.Exists(PathToSave))
            {
                Directory.CreateDirectory(PathToSave);
            }
            var fileName = Path.GetFileName(model.File.FileName);
            var FullPath = Path.Combine(PathToSave, fileName);
            var dbPath = Path.Combine(folderName, fileName);
            if (System.IO.File.Exists(dbPath))
            {
                return BadRequest("File already exist");
            }
            await using (var stream = new FileStream(FullPath, FileMode.Create))
            {
                await model.File.CopyToAsync(stream);
            }


            return Ok(new { dbPath });
        }
    }
}
