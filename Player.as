package  
{
	import mx.core.ButtonAsset;
	import org.flixel.*;
	/**
	 * ...
	 * @author Kathy
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = "data/g_guy.png")] protected var Imgshinobi:Class;
		protected var _jump:int;
		protected var _aim:uint;
		protected var _bullets:FlxGroup;
		protected var _shottimer:Number;
		
		public function Player(X:int, Y:int, Bullets:FlxGroup) 
		{
			super(X, Y);
			loadGraphic(Imgshinobi, true, true, 15,24);  //loads the spritesheet provided
			
			//bounding box values
			width = 15;
			height = 24;
			offset.x = 1;
			offset.y = 1;
			
			//simple player physics
			var runSpeed:uint = 100;
			drag.x = runSpeed * 4;
	
			//gravity
			acceleration.y = 200;
			_jump = 160;
			maxVelocity.x = runSpeed;
			maxVelocity.y = _jump;
			
			addAnimation("idle", [0], 2);  //use the sprite at this location in the spritesheet as the idle state
			addAnimation("run", [4, 5], 8); //use these frames 12 times
			addAnimation("jump", [4], 2); //yay for jumping
			
			_bullets = Bullets;
			_shottimer = 5;
		}
		
		override public function destroy():void 
		{
				super.destroy();
				_bullets = null;
		}
		
		override public function update():void 
		{
			//MOVEMENT
			acceleration.x = 0; //stop your sprite from flying off the screen
			_shottimer += FlxG.elapsed;
			
			if(FlxG.keys.LEFT)
			{
				facing = RIGHT;
				_aim = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = LEFT;
				_aim = RIGHT;
				acceleration.x += drag.x;
			}
			
			if(FlxG.keys.justPressed("UP") && !velocity.y)
			{
				velocity.y = -_jump;
				//FlxG.play(SndJump);  //play some jumping sound
			}
			
			//ANIMATION
			if(velocity.y != 0)
			{
				//if(_aim == UP) play("jump_up");
				//else if(_aim == DOWN) play("jump_down");
				play("jump");
			}
			else if(velocity.x == 0)
			{
				//if(_aim == UP) play("idle_up");
				play("jump");
			}
			else
			{
				//if(_aim == UP) play("run_up");
				play("run");
			}

			if (FlxG.keys.justPressed("SPACE") && _shottimer > 0.8) 
			{
				_shottimer = 0;
				getMidpoint(_point);
				//make the bullet move
				(_bullets.recycle(Bullet) as Bullet).shoot(_point, _aim);
			}
			
		}
		
		override public function hurt(Damage:Number):void 
		{
			Damage = 0;
			if (FlxG.score > 50)
				FlxG.score -= 50;
			else
				FlxG.score = 0;
				
			super.hurt(Damage);
			
			FlxG.camera.shake(0.02, 0.45);
			FlxG.camera.flash(0xffaaffff, 0.25);
		}
		
	}

}