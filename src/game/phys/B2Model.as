package game.phys  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import game.math.To;
	import scenes.PlayScene;
	/**
	 * ...
	 * @author Gayan
	 */
	public class B2Model 
	{
		// body
		public var body:b2Body;
		
		public function B2Model(type:uint, w:uint, h:uint, position:b2Vec2, density:uint = 1) 
		{
			// body definition
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = type;
			bodyDef.position.Set(To.m(position.x), To.m(position.y));
			
			// shape
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(To.m(w) * 0.5, To.m(h) * 0.5);
			
			// fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.density = density;
			fixtureDef.friction = 1;
			
						
			// create body
			body = PlayScene.world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetLinearDamping(1);
			body.SetAngularDamping(2);
		}
		
	}

}