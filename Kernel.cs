using System;
using System.Collections.Generic;
using System.Text;
using SystemOS = Cosmos.System;

namespace OS
{
    public class Kernel : SystemOS.Kernel
    {

        protected override void BeforeRun()
        {

        }

        protected override void Run()
        {
            Console.Write("Загруженно.");
        }
    }
}
