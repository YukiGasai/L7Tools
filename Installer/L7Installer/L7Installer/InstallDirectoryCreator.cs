using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace L7Installer
{
    class InstallDirectoryCreator
    {
        private String InstallDirectory = "";

        private const String DEFAULT_INSTALL_PATH = "C:\\L7Tools";


        public InstallDirectoryCreator()
        {

            while (string.IsNullOrEmpty(getInstallDirectory())) {
                EnterPath();
            }
       
            if (!Directory.Exists(getInstallDirectory()))
            {
                Directory.CreateDirectory(getInstallDirectory());
            }
        }


        private void EnterPath()
        {
            Console.Clear();
            Console.WriteLine("Enter desired Install location:");
            Console.WriteLine("(Default " + DEFAULT_INSTALL_PATH + ")");
            String EnterdPath = Console.ReadLine();

            if (!string.IsNullOrEmpty(EnterdPath))
            {
                if (!Directory.Exists(EnterdPath))
                {
                    setInstallDirectory(EnterdPath);
                }
            }
            else
            {  
                setInstallDirectory(DEFAULT_INSTALL_PATH);
            }
        }


        private Boolean setInstallDirectory(String newInstallDirectory)
        {
            if (Path.IsPathFullyQualified(newInstallDirectory))
            {
                InstallDirectory = newInstallDirectory;
                return true;
            }

            return false;
            
        }

        public String getInstallDirectory()
        {
            return InstallDirectory;
        }

    }
}
