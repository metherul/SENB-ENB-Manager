using System.Collections.Generic;
using System.IO;

namespace SENB_ENB_Manager.Model
{
    public class FileMap
    {
        string Name;
        string Path;
        string FileExtension;
        long SizeInBytes;

        public FileMap(string _path)
        {
            Name = new FileInfo(_path).Name;
            Path = _path;
            FileExtension = System.IO.Path.GetExtension(_path);
            SizeInBytes = new FileInfo(_path).Length;
        }
    }

    public class DirectoryMap
    {
        string Name;
        string Path;
        int SubFileCount;
        int SubDirectoryCount;
        List<FileMap> SubFiles;
        List<DirectoryMap> SubDirectories;

        public DirectoryMap(string _path)
        {
            Name = new DirectoryInfo(_path).Name;
            Path = _path;
            SubFileCount = Directory.GetFiles(_path).Length;
            SubDirectoryCount = Directory.GetDirectories(_path).Length;
            SubFiles = new List<FileMap>();
            SubDirectories = new List<DirectoryMap>();

            foreach (var file in Directory.GetFiles(_path))
            {
                SubFiles.Add(new FileMap(file));
            }

            foreach (var directory in Directory.GetDirectories(_path))
            {
                SubDirectories.Add(new DirectoryMap(directory));
            }
        }
    }

    public enum Type
    {
        File,
        Directory
    }

}

