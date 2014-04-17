package game.phys 
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author ...
	 */
	public class DynamicBox 
	{
		private var _body:Body;
		
		// vector that holds all the dynamic boxes
		public static var boxes:Vector.<DynamicBox> = new Vector.<DynamicBox>;
		
		// view
		private var _texture:Texture;
		private var _image:Image;
		
		public function DynamicBox(position:Vec2, w:Number = 32, h:Number = 32) 
		{
			// init body
			_body = new Body(BodyType.DYNAMIC, position);
			_body.shapes.add(new Polygon(Polygon.box(w, h)));
			_body.space = Phys.space;
			
			// add box to the list
			boxes.push(this);
			
			createView();
		}
		
		private function createView():void 
		{
			_texture = Game.assets.getTexture("enemy");
			_image = new Image(_texture);
			_image.alignPivot();
			Starling.current.stage.addChild(_image);
		}
		
		private function updateView():void
		{
			_image.x = _body.position.x;
			_image.y = _body.position.y;
			_image.rotation = _body.rotation;
		}
		
		public static function updateViews():void
		{
			for (var i:int = 0; i < boxes.length; ++i)
			{
				boxes[i].updateView();
			}
		}
		
	}

}