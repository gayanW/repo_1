package game 
{
	import starling.errors.AbstractClassError;
	/**
	 * ...
	 * @author Gayan
	 */
	public class Action 
	{
		public static const ADD_OBJECT:uint = 0;
		public static const SET_ENEMY_TARGET:uint = 1;
		
		public function Action() { throw new AbstractClassError(); }
		
	}

}