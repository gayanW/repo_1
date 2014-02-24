package game.player 
{
	import Box2D.Common.Math.b2Vec2;
	import game.Key;
	import game.phys.B2Model;
	import game.phys.Phys;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	/**
	 * ...
	 * @author Gayan
	 */
	public class Player 
	{
		
		private var force:Number;
		private var acceleration:Number;
		public var body:Body;
		
		public function Player(position:Vec2, w:Number = 26, h:Number= 26) 
		{
			initBody(position, w, h);
		
			acceleration = 3;
			force = body.mass * acceleration;
		
		}
		
		private function initBody(position:Vec2, w:Number, h:Number):void 
		{
			// shape
			var shape:Polygon = new Polygon(Polygon.box(w, h));
			//shape.material = Material.rubber();
			
			
			// body
			body = new Body(BodyType.DYNAMIC, position);
			body.shapes.add(shape);
			body.position = position;
			body.allowRotation = false;
			body.space = Phys.space;
			
		}
		
		public function update():void
		{
			if (Key.UP) {
				body.applyImpulse(Vec2.weak(0, -force));
			}	
			
			if (Key.DOWN) {
				body.applyImpulse(Vec2.weak(0, force));
			}
			
			if (Key.LEFT) {
				body.applyImpulse(Vec2.weak( -force, 0));
			}
			
			if (Key.RIGHT) { 
				body.applyImpulse(Vec2.weak(force, 0));
			}
		}
		
		public function get position():Vec2
		{
			return body.position;
		}
		
	}

}