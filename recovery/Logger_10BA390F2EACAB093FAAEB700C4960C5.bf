//Copyright: Booklordofthedings, but use it for whatever your want
using System;
using System.Collections;
namespace BeefLog
{
	class Logger
	{
		//So the user can choose how he wants stuff to be logged
		public enum LoggType
		{
			console,
			file,
			cf
		}
		//The log thats used, if there is no type specified
		private static LoggType DefaultLoggType = .cf;
		//Where we keep the current logs
		private static List<logData> LogData;

	}

	class logData
	{

	}
}
