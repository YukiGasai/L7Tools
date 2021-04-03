using LibGit2Sharp;
using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace L7Installer
{
    class Program
    {
        static void Main(string[] args)
        {
            //Will create the Install Directory
            InstallDirectoryCreator installDirectoryCreator = new InstallDirectoryCreator();


            Task.Run(() =>
            {
                Repository.Clone("https://github.com/YukiGasai/L7Tools.git", Path.GetFullPath(installDirectoryCreator.getInstallDirectory()),
                    new CloneOptions { OnTransferProgress = Program.TransferProgress });
            }).Wait();
        }

        public static bool TransferProgress(TransferProgress progress)
        {
            Console.WriteLine($"Objects: {progress.ReceivedObjects} of {progress.TotalObjects}, Bytes: {progress.ReceivedBytes}");
            return true;
        }

        StringBuilder stringBuilder = new StringBuilder();


    }
}