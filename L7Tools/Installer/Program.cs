using System;
using System.Net;


namespace Installer
{
    class Program
    {
        static void Main(string[] args)
        {
            if(args.Length == 0)
            {
                Console.WriteLine("EEE");
            }else if(args[0] == "Install")
            {
                WebClient webClient = new WebClient();
                webClient.DownloadFile("https://raw.githubusercontent.com/YukiGasai/L7Tools/master/AHK/BasicFunctions.ahk?token=AJDBBEGO7WMG7W6C4BAD3427VA5EM", @".\Compiler\Base.ahk");
                Console.WriteLine("Fertig");
            }
        }
    }
}
