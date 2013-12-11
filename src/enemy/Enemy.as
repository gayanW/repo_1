package enemy 
{
	import game.phys.Phys;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	/**
	 * ...
	 * @author Gayan
	 */
	public class Enemy 
	{
		public var body:Body;
		
		// variables required for movement
		private var _pointA:Vec2;
		private var _pointB:Vec2;
		private var _target:Vec2;
		
		private var _updateCount:uint = 0;
		private var _updateLimit:uint = 5000;
		
		private var _direction:Vec2;
		
		public static var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		
		public function Enemy(position:Vec2, targetPos:Vec2, w:Number = 25, h:Number = 25) 
		{	
			initVars(position, targetPos);
			initBody(position, w, h);
			
			// set initial target
			target = _pointB;

			// add enemy to list
			enemies.push(this);
		}
		
		private function initVars(position:Vec2, targetPos:Vec2):void 
		{
			_pointA = position;
			_pointB = targetPos;
			
		}
		
		private function initBody(position:Vec2, w:Number, h:Number):void 
		{
			// shape
			var shape:Shape = new Polygon(Polygon.box(w, h));
			shape.material = Material.rubber();
			
			body = new Body(BodyType.KINEMATIC, position);
			body.shapes.add(shape);
			body.position = position;
			
			body.space = Phys.space;
		}
		
		public function update():void
		{
			if (true)
			{	
				if (Vec2.distance(position, target) < 1)
				{	
					// switch targets
					if (target == _pointA) target = _pointB;
					else target = _pointA;
				}
				
				// move towards the target location
				body.position.addeq(_direction);
			}
				
		}
		
		public function set target(location:Vec2):void
		{	
			_target = location;
			// compute velcity according to the new target
			_direction = _target.sub(position).unit();
		}
		
		public function get target():Vec2
		{
			return _target;
		}
		
		public function get position():Vec2
		{
			return body.position;
		}
		
		public function get direction():Vec2
		{
			return _direction;
		}
		
		public static function at(index:uint):Enemy
		{
			return enemies[index];
		}
		
		public static function positionAt(index:uint):Vec2
		{
			return enemies[index].position;
		}
		
		
		
	}

}