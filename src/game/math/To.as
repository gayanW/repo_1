package game.math 
{
	import game.phys.Phys;
	import starling.errors.AbstractClassError;
	/**
	 * ...
	 * @author Gayan
	 */
	public class To 
	{
		private static const METERS_TO_PIXEL:Number = 1 / Phys.SCALE;
		
		private static const PIXELS_TO_METER:Number = Phys.SCALE;
		
		public function To() { throw new AbstractClassError(); }
		
		/**
		 * Convert meters to pixel
		 * @param	m	The value in meters
		*/
		public static function px(m:Number):Number
		{
			return m * PIXELS_TO_METER;
		}
		
		/**
		 * Convert pixels to meters
		 * @param	px	The value in pixels
		*/
		public static function m(px:Number):Number
		{
			return px * METERS_TO_PIXEL;
		}
		
	}

}