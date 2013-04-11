package
{
	import flash.geom.Point;

	import org.flixel.*;

	public class Enemy extends FlxSprite
	{
		[Embed(source="data/ghost.png")] protected var ImgGhost:Class;

		//References to other game objects:
		protected var _player:Player;	//The player object
		protected var _bullets:FlxGroup;	//A group of enemy bullet objects (Enemies shoot these out)
		
		public var espeed:int;

		//This is the constructor for the enemy class. Because we are
		//recycling enemies, we don't want our constructor to have any
		//required parameters.
		public function Enemy(X:int, Y:int, PLAYER:Player, BULLETS:FlxGroup)
		{
			super(X,Y);
			loadGraphic(ImgGhost, true, true, 25, 30);
			
			_player = PLAYER;
			_bullets = BULLETS;
			
			width = 6;
			height = 7;
			centerOffsets();
			
			espeed = 40;
			//drag.x = 35;
			
			addAnimation("normal", [0], 2);
			play("normal");
		}

		//This is the main flixel update function or loop function.
		//Most of the enemy's logic or behavior is in this function here.
		override public function update():void
		{	
			if(_player.x + _player.width/2 < this.x)
			{
				facing = RIGHT;
				velocity.x = -espeed;
			}
			else if(_player.x + _player.width/2 >= this.x)
			{
				facing = LEFT;
				velocity.x = espeed;
			}
			
			if(_player.y + _player.height/2 > this.y)
			{
				velocity.y = espeed;
			}
			else if(_player.y + _player.height/2 <= this.y)
			{
				velocity.y = -espeed;
			}

			super.update();
		}

		//This function is called when player bullets hit the Enemy.
		//The enemy is told to flicker, points are awarded to the player,
		//and damage is dealt to the Enemy.
		override public function hurt(Damage:Number):void
		{
			flicker(0.2);
			super.hurt(Damage);
		}
		
		
		//Called by flixel to help clean up memory.
		override public function destroy():void
		{
			super.destroy();

			_player = null;
			_bullets = null;
			alive = false;
			solid = false;
		}
		
		//Called to kill the enemy. A cool sound is played,
		//the jets are turned off, bits are exploded, and points are rewarded.
		override public function kill():void
		{
			if(!alive)
				return;
			super.kill();
			alive = false;
			solid = false;
			FlxG.score += 20;
		}
	}
}