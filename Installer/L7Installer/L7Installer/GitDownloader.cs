using LibGit2Sharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace L7Installer
{
    class GitDownloader
    {

        public GitDownloader()
        {
            string logMessage = "";
            using (var repo = new Repository("https://github.com/YukiGasai/L7Tools.git"))
            {
                var remote = repo.Network.Remotes["origin"];
                var refSpecs = remote.FetchRefSpecs.Select(x => x.Specification);
                Commands.Fetch(repo, remote.Name, refSpecs, null, logMessage);
            }
            Console.WriteLine(logMessage);
        }
    }
}
