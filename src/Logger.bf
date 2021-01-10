//The ultimate* single File logging program for beef
//*ultimate meaning, mostly trash, but if someone wants to use it he can
//Warning: You shouldnt use this async, it would likely break
//Copyright: Booklordofthedings, but use it for whatever your want
using System;
using System.Collections;
using System.IO;
namespace BeefLog
{
	class Logger 
	{
		//Add your custom message types here
		public enum MessageType
		{
			Logger,
			ERROR,
			Info,
			Warning
		}
		//This decides how a message fill be logged
		public enum LoggType
		{
			console,
			file,
			cf
		}
		
		private static String LogFileName = new String("log") ~ delete(_);
		public static String GetLogFileName() {return LogFileName;}
		public static void SetLogFileName(String Input) {LogFileName = Input;}
		private static String LogPath ~ delete(_);
		public static String GetLogPath() {if(LogPath != null) {return LogPath;}
			else
				{
					LogPath = new String();
					Directory.GetCurrentDirectory(LogPath);
				} return LogPath;}
		public static void SetLogPath(String Input) {LogPath = Input;}
		//Defaults
		private static LoggType DefaultLogType = .cf;
		public static LoggType GetDefaultLogType() {return DefaultLogType;}
		public static void SetDefaultLogType(LoggType Input){ DefaultLogType = Input;}
		private static MessageType DefaultMessageType = .Info;
		public static MessageType GetDefaultMessageType() {return DefaultMessageType;}
		public static void SetDefaultMessageType(MessageType Input) {DefaultMessageType = Input;}
		private static int DefaultMessageID = 1; //This should be kept at a maximum of 8 characters long
		public static int GetDefaultMessageID() {return DefaultMessageID;}
		public static void SetDefaultMessageID(int Input) {DefaultMessageID = Input;}

		//Where we keep the current logs
		private static List<Logger> LogData = new List<Logger>() ~ DeleteContainerAndItems!(_); 
		private static int DefaultCleanMax = 1000;
		public static int GetDefaultCleanMax() {return DefaultCleanMax;}
		public static void SetDefaultCleanMax(int Input) {DefaultCleanMax = Input;}
		///Log a message with the default log
		public static void Log(String Message) { Log(Message,DefaultLogType,DefaultMessageType,DefaultMessageID); }
		public static void Log(String Message,MessageType MessageType,int MessageID) {Log(Message,DefaultLogType,MessageType,MessageID);}
		public static void Log(String Message,int MessageID) {Log(Message,DefaultLogType,DefaultMessageType,MessageID);}
		///Log a message with the specified Log Type
		public static void Log(String Message,LoggType lType,MessageType MessageType,int MessageID)
		{
			Logger x;
			switch(lType)
			{
				case .cf:
					 x = new Logger(Message,true,MessageType,MessageID);
					 Console.Write(x.m);
				break;
				case .console:
				 	x = new Logger(Message,false,MessageType,MessageID);
					Console.Write(x.m);
				break;
				case .file:
				 	x = new Logger(Message,true,MessageType,MessageID);
				break;
			}
			LogData.Add(x);

			//Clear out the memory, if we ever reach to many logs
			if(LogData.Count > DefaultCleanMax)
				LogToFile();
		}
		///Clear the current saved log buffer and write everything thats supposed to go into a file into a file
		public static void LogToFile()
		{
			if(LogPath == null)
			{
				LogPath = new String();
				Directory.GetCurrentDirectory(LogPath);
			}
			String path = scope String(scope $"{LogPath}\\{LogFileName}.log");
			FileStream fs = scope FileStream();
			var result = fs.Open(path,.Append,.Write);
			for(Logger d in LogData)
			{
				if(d.infile)
				{
					fs.TryWrite(.((uint8*)d.m.Ptr,d.m.Length));
				}
			}
			LogData.Clear();
		}


		//This was originally in another class, but to make it less confusing and in order to be able to hide the constructor I
		//moved it in here

		//Date of the log
		private DateTime mdtime;
		private Logger.MessageType mtype;
		private bool infile;
		private int logid; //The maximum id should have a lenght of 8
		//Generated log string
		private String m;
		//Constructor
		private this(String message, bool file,Logger.MessageType mType,int logID)
		{
			//Setting variables
			infile = file; logid = logID; mtype = mType; mdtime = DateTime.Now;
			//Creating the output string
			String MType = scope String(); mtype.ToString(MType);
			String logIDString = scope String(); logid.ToString(logIDString,"D8",scope System.Globalization.NumberFormatInfo());
			m = new String(scope $"[{DateTime.Now.ToUniversalTime()}][{MType}][{logIDString}]:{message} \n");
		}
		//Destructor
		private ~this() { delete(this.m); }
	}
}
