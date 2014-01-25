package game.enemy 
{
	import game.Dir;
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
		
		private var _type:uint;
		
		public static var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		
		public function Enemy
				(
					type:uint, position:Vec2, 
					targetPos:Vec2 = null, direction:uint = Dir.RIGHT, 
					w:Number = 26, h:Number = 26
				) 
		{	
			initVars(type, position, targetPos);
			initBody(position, w, h);
			
			// set initial target
			if (_type == EnemyType.PATROL)
				target = _pointB;
			else	// if there's no target, just set the eye direction
				setDirection(direction);

			// add enemy to list
			enemies.push(this);
		}
		
		private function initVars(type:uint, position:Vec2, targetPos:Vec2):void 
		{
			_type = type;
			_pointA = position;
			_pointB = targetPos;
			
		}
		
		private function initBody(position:Vec2, w:Number, h:Number):void 
		{
			body = new Body(BodyType.KINEMATIC, position);
			
			var shape:Shape = new Polygon(Polygon.box(w, h));
			body.shapes.add(shape);
			body.setShapeMaterials(Material.rubber());
			
			body.space = Phys.space;
		}
		
		public function update():void
		{
			if (_type == EnemyType.PATROL)
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
		
		/* set direction for enemy guards
		 * without setting any target */
		private function  setDirection(direction:uint):void
		{
			var dir:Vec2;
			
			switch (direction)
			{
				case Dir.UP:
					dir = new Vec2(0, 1);
					break;
				case Dir.DOWN:
					dir = new Vec2(0, -1);
					break;
				case Dir.LEFT:
					dir = new Vec2( -1, 0);
					break;
				case Dir.RIGHT:
					dir = new Vec2(1, 0);
					break;
			}
			
			_direction = dir.unit();
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