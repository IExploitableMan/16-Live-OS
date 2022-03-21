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
			Command[] commands =
			{
				new Command("помогите", "Даёт никому не нужную помощь", new List<string> { "хелп" }),
			};
			Console.Write("Загруженно.");
		}
	}

	public class Command 
	{
		public string Name { get; set; }
		public string Description { get; set; }
		public List<string> Aliases { get; set; }

		public Command(string _name, string _description, List<string> aliases) 
		{
			Name = _name;
			Description = _description;
			Aliases = aliases;
		}
	}
}
