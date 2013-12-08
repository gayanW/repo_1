package game
{
	import starling.errors.AbstractClassError;
	
	/**
	 * ...
	 * @author Gayan
	 */
	public class Key 
	{
		public static var UP:Boolean = false;
		public static var DOWN:Boolean = false;
		public static var LEFT:Boolean = false;
		public static var RIGHT:Boolean = false;
		
		public function Key() 
		{
			throw new AbstractClassError();
		}
		
	}

}