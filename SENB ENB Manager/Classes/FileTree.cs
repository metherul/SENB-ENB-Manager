using System.Collections.Generic;

namespace SENB_ENB_Manager.Classes
{
    public class File
    {
        string Name;
        string Path;
        string FileExtension;
        long SizeInBytes;

        public File(string _path)
        {
            Name = new System.IO.FileInfo(_path).Name;
            Path = _path;
            FileExtension = System.IO.Path.GetExtension(_path);
            SizeInBytes = new System.IO.FileInfo(_path).Length;
        }
    }

    public class Directory
    {
        string Name;
        string Path;
        int SubFileCount;
        int SubDirectoryCount;
        List<File> SubFiles;
        List<Directory> SubDirectories;

        public Directory(string _path)
        {
            Name = new System.IO.DirectoryInfo(_path).Name;
            Path = _path;
            SubFileCount = System.IO.Directory.GetFiles(_path).Length;
            SubDirectoryCount = System.IO.Directory.GetDirectories(_path).Length;
            SubFiles = new List<File>();
            SubDirectories = new List<Directory>();

            foreach (var file in System.IO.Directory.GetFiles(_path))
            {
                SubFiles.Add(new File(file));
            }

            foreach (var directory in System.IO.Directory.GetDirectories(_path))
            {
                SubDirectories.Add(new Directory(directory));
            }
        }
    }

    public enum Type
    {
        File,
        Directory
    }

}

