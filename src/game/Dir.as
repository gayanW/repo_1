package game
{
	/**
	 * ...
	 * @author Gayan
	 */
	public class Dir 
	{
		public static const UP:uint = 0;
		public static const DOWN:uint = 1;
		public static const LEFT:uint = 2;
		public static const RIGHT:uint = 3;
		
		public static const NONE:uint = 9;
		
		public function Dir() 
		{
			
		}
		
		public static function str2uint(string:String):uint
		{
			if (string == "up") return UP;
			else if (string == "down") return DOWN;
			else if (string == "left") return LEFT;
			else if (string == "right") return RIGHT;
			
			return NONE;
		}
		
	}

}