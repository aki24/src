package
{
	import org.flixel.*;

	public class Bullet extends FlxSprite
	{
		public var speed:Number;

		public function Bullet()
		{
			super();
			new FlxSprite();
			makeGraphic(5, 5, 0xffaa1111);
			width = 6;
			height = 6;
			offset.x = 1;
			offset.y = 1;

			speed = 360;
		}

		override public function update():void
		{
			if(!alive)
			{
				if(finished)
					exists = false;
			}
			else if (touching)
				kill();
		}

		public function shoot(Location:FlxPoint, Aim:uint):void
		{
			super.reset(Location.x-width/2,Location.y-height/2);
			solid = true;
			switch(Aim)
			{
				case LEFT:
					velocity.x = -speed;
					break;
				case RIGHT:
					velocity.x = speed;
					break;
				default:
					break;
			}
		}
	}
}