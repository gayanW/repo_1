package game 
{
	import Box2D.Dynamics.b2Body;
	import starling.errors.AbstractClassError;
	/**
	 * ...
	 * @author Gayan
	 */
	public class Obj 
	{
		public static const STATIC:uint = 0;
		public static const KINEMATIC:uint = 1;
		public static const DYNAMIC:uint = 2;
		
		public static const PLAYER:uint = 3;
		public static const ENEMY:uint = 4;
		
		public function Obj() 
		{
			throw new AbstractClassError();
		}
		
		public function addObstacles():void 
		{
			
		}
		
	}

}