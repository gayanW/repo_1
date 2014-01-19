package scenes 
{
	import flash.ui.Keyboard;
	import game.Action;
	import game.Dir;
	import game.enemy.Enemy;
	import game.enemy.EnemyType;
	import game.math.To;
	import game.Obj;
	import game.phys.Phys;
	import game.player.Player;
	import game.player.PlayerController;
	import nape.geom.Ray;
	import nape.geom.RayResult;
	import nape.geom.RayResultList;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.space.Space;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	import flash.display.Sprite;
	
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Gayan
	 */
	public class PlayScene extends Scene
	{
		// player
		private var _player:Player;
		private var _playerController:PlayerController;
		
		// enemy
		private var _enemy:Enemy;
		private var _newTarget:Vec2;
		
		
		// variables required for user interactivity
		private var _defObj:uint;
		private var _defAction:uint;
		
		private var _ray:Ray;
		private var _rayResult:RayResult;
		private var _rayResultList:RayResultList;
		private var _intersection:Vec2;
		private var _inRange:Boolean;
		private var _raySprite:flash.display.Sprite;
		
		
		public function PlayScene() 
		{
			// init Nape
			var gravity:Vec2 = Vec2.weak(0, 0);
			Phys.initNape(gravity);
						
			// create static border
			Phys.createBounderies();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// add level data
			var levelData:Object = Game.assets.getObject("level_data");
			var xmlData:Object = Game.assets.getXml("xml_data");
			
			// add obstacels
			var obstacles:XMLList = xmlData.objectgroup.(@name == "obstacles").object;
			
			for each(var obstacle:XML in obstacles)
			{
				var position:Vec2 = new Vec2(obstacle.@x, obstacle.@y); 
				Phys.addObstacle(position, obstacle.@width, obstacle.@height);
			}
			
			// add enemies
			var enemies:XMLList = xmlData.objectgroup.(@name == "enemies").object;
			
			for each(var enemy:XML in enemies)
			{
				position = new Vec2(enemy.@x, enemy.@y);
				
				var property:XMLList = enemy.properties.property;
				var type:String = property.(@name == "type").@value;
				
				if (type == "patrol")
				{
					var targetX:Number = property.(@name == "targetX").@value;
					var targetY:Number = property.(@name == "targetY").@value;
					var target:Vec2 = new Vec2(targetX, targetY);
					
					var newEnemy:Enemy = new Enemy(EnemyType.PATROL, position, target);
				}
				else
				{
					var newEnemy:Enemy = new Enemy(EnemyType.GUARD, position);
				}
				
				
			}
			
			// add player
			position = new Vec2(Const.CenterX, Const.CenterY);
			_player = new Player(position);
			_playerController = new PlayerController(_player, stage);
			
			// add enemy
			//_enemy = new Enemy(new Vec2(30, 30), _newTarget);
			
			// add some static objects
			//setupWorld();
			
			// debug sprites
			_raySprite = new flash.display.Sprite();
			Starling.current.nativeOverlay.addChild(Phys.debugSprite);
			Starling.current.nativeOverlay.addChild(_raySprite);
			
			// add event listeners
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function setupWorld():void 
		{
			var w:Number = 30;
			var h:Number = 30;
			var i:int = 0;
			
			// add few random obstacles  
			var obstacles:Body = new Body(BodyType.DYNAMIC);
			while (++i < 11)
				obstacles.shapes.add(new Polygon
					(
						Polygon.rect
							(
								Math.random() * Const.GameWidth, 
								Math.random() * Const.GameHeight, w, h)));
				
			obstacles.space = Phys.space;
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.ENDED);
			
			if (touch)
			{
				// record touch position
				var position:Vec2 = new Vec2(touch.globalX, touch.globalY);
				
				// choose what action to perform
				switch (_defAction)
				{
					case Action.ADD_OBJECT:
						// select the object that needs to be added
						switch (_defObj)
						{
							case Obj.ENEMY:
								break;
								
							case Obj.STATIC:
								Phys.addObstacle(position);
								break;
								
							case Obj.DYNAMIC:
								Phys.addDynamicBox(position);
								break;
						}
						break;
						
					case Action.SET_ENEMY_TARGET:
						_newTarget = position;
						break;
						
				}
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			// handle keyboard events
			if (e.keyCode == Keyboard.E) {
				_defAction = Action.ADD_OBJECT;
				_defObj = Obj.ENEMY;
			}
			else if (e.keyCode == Keyboard.NUMBER_0) {
				_defAction = Action.ADD_OBJECT;
				_defObj = Obj.STATIC;
			}
			else if (e.keyCode == Keyboard.NUMBER_2) {
				_defAction = Action.ADD_OBJECT;
				_defObj = Obj.DYNAMIC;
			}
			else if (e.keyCode == Keyboard.T) {
				_defAction = Action.SET_ENEMY_TARGET;
			}
				
		}
		
		private function onEnterFrame(e:Event):void 
		{
			// update space
			Phys.space.step(Const.TIME_STEP);
			
			// update player
			_player.update();
			
			// update enemies
			updateEnemies();
			
			// ray cast
			rayCast();
			
			
			// debug draw
			Phys.debugDraw();
			
		}
		
		private function updateEnemies():void 
		{
			for (var i:int = 0; i < Enemy.enemies.length; ++i)
			{
				Enemy.at(i).update();
			}
		}
		
		private function rayCast():void 
		{
			_raySprite.graphics.clear();
			
			
			// iterate through all the enemies
			for (var i:int = 0; i < Enemy.enemies.length; ++i)
			{
				var currentEnemy:Enemy = Enemy.at(i);
				var enemyPos:Vec2 = Enemy.positionAt(i);
				
				// cast a ray from enemy to player
				_ray = Ray.fromSegment(enemyPos, _player.position);
				_ray.maxDistance = 300;
				
				// check if the ray is withing the enemy's sight
				/* angle between two vectors
				 * angle = acos(dotProduct / (magV1 * magV2)) */
				
				var dotProduct:Number = currentEnemy.direction.dot(_ray.direction);
				var angle:Number = Math.acos(dotProduct / (currentEnemy.direction.length * _ray.direction.length));
				
				if (angle < Math.PI * 0.4)
					_inRange = true;
				else
					_inRange = false;
					
				_rayResult = Phys.space.rayCast(_ray);
				
				if (_rayResult && _inRange)
				{	
					//if (_rayResult.shape.body == _player.body)
					//{
						_intersection = _ray.at(_rayResult.distance);
						
						// draw
						if (_inRange) _raySprite.graphics.lineStyle(1, Color.RED);
						_raySprite.graphics.moveTo(enemyPos.x, enemyPos.y);
						_raySprite.graphics.lineTo(_intersection.x, _intersection.y);
					
					//}
					
					
				}

			}
			
			
			
			
		}
		
		
	}

}