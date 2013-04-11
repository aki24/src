package  
{
	/**
	 * ...
	 * @author Kathy
	 */
	import org.flixel.*;
	 
	public class BackDrop extends FlxSprite 
	{
		[Embed(source = "data/bg.jpg")] protected var ImgBackdrop:Class;
		public function BackDrop(x:Number, y:Number, BackDropScroll:Number) 
		{
			super(x, y);
			loadGraphic(ImgBackdrop, false, false, 1920, 1080, false);
			scrollFactor.x = scrollFactor.y = BackDropScroll;
			solid = false;
		}
		
	}

}