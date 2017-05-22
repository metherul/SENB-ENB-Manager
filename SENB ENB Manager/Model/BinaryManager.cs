using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace SENB_ENB_Manager.Model
{
    public class BinaryManager
    {
        public Dictionary<string, string> BinaryHashDictionary = new Dictionary<string, string>()
        {
            {"v0292", "958C7AC259CDCB520DC768692ADDC1D8"},
            {"v0308", "0180BFE4D2F26392748F6A75D808665B"},
            {"v0108", "25FE160335B3C71FD2587A6D78A11EA0"},
            {"v0117", "7DBC60F9EA04AD9E73B4F7AC9C5FF52C"},
            {"v0119", "F76DEB480A59148B7F75393C98811953"},
            {"v121212", "5C2775DEF3968D22A5DE876988FABAD3"},
            {"v0132", "68E690ADDE5D89A5F4FA7DC642447D24"},
            {"v0168", "82629EAB83233780B4CF9A091D1B422B"},
            {"v13713", "413B47F15B5C2E9F2EE73E17644FF641"},
            {"v0221", "EF2B6E7165EE3B541BFA806D39F3D38C"},
            {"v0236", "BE0AE396224E172603B170143DA58D6D"},
            {"v0262", "1E18C7F483355C04C650BC701F009276"},
            {"v0102", "4F3277DCCE171FD8A5D505675D6BF029"}

        };

        public Dictionary<string, string> BinaryFileSizeDictionary = new Dictionary<string, string>()
        {
            {"v.0102", "208384"},
            {"v.0108", "203776"},
            {"v.0117", "472576"},
            {"v.0119", "473600"},
            {"v.0132", "726016"},
            {"v.0168", "781312"},
            {"v.0221", "820736"},
            {"v.0236", "866304"},
            {"v.0262", "947712"},
            {"v.0292", "922112"},
            {"v.0308", "925696"},
            {"v.121212", "493056"},
            {"v.13713", "809472"}
        };

        private static string GetHash(string path)
        {
            using (var md5 = MD5.Create())
            {
                using (var stream = File.OpenRead(path))
                {
                    return BitConverter.ToString(md5.ComputeHash(stream)).Replace("-", string.Empty);
                }
            }
        }

        private static string GetFileSize(string path)
        {
            return new FileInfo(path).Length.ToString();
        }

        public string GetBinaryVersion(string path)
        {
            var fileSize = GetFileSize(path);
            var value = BinaryFileSizeDictionary.FirstOrDefault(x => x.Value == fileSize).Key;

            return value;
        }
    }
}
