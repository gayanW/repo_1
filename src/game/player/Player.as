package game.player 
{
	import game.Key;
	import game.phys.Phys;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Gayan
	 */
	public class Player 
	{
		
		private var force:Number;
		private var acceleration:Number;
		public var body:Body;
		
		private static var _texture:Texture;
		public var view:Image;
		
		public function Player(position:Vec2, w:Number = 24, h:Number= 24) 
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
			
			// view
			createView();
		}
		
		private function createView():void 
		{
			_texture = Game.assets.getTexture("enemy");
			view = new Image(_texture);
			view.alignPivot();
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
		
		public function updateView():void
		{
			view.x = body.position.x;
			view.y = body.position.y;
		}
		
		public function get position():Vec2
		{
			return body.position;
		}
		
	}

}