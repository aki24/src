package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source = "data/mario_tiles.png")] protected var Imgtile:Class;
		
		protected var _player:Player;
		protected var _objects:FlxGroup;
		protected var _blocks:FlxGroup;
		protected var _bullets:FlxGroup;
		protected var _enemies:FlxGroup;
		protected var _bd: BackDrop;
		protected var _timer:Number;
		protected var level:FlxTilemap;
		protected var _score:FlxText;
		
		override public function create():void
		{
			_blocks = new FlxGroup();
			_bullets = new FlxGroup();
			_enemies = new FlxGroup();
			
			_player = new Player(160, 135, _bullets);
			_bd = new BackDrop( 0, 0, 1);
			
			FlxG.score = 100;
			_score = new FlxText(FlxG.width/4,0,FlxG.width/2);
			_score.setFormat(null,16,0xd8eba2,"center",0x131c1b);
			//_score = new FlxText(2, 2, 80);
			_score.text = "Score: " + FlxG.score;
			_timer = 5;
			
			generateLevel();
			
			for (var e:int = 0; e < 10; e++)
			{
				_enemies.add(new Enemy(Math.random()*100, Math.random()*100, _player, _bullets));
			}
			
			add(_bd);
			add(_blocks);
			add(_enemies);
			add(_score);
			add(_player);
			add(_bullets);
			
			//FlxG.camera.setBounds(0, 0, 640, 480, true);
			//FlxG.camera.follow(_player,FlxCamera.STYLE_PLATFORMER);

			_objects = new FlxGroup();
			_objects.add(_player);
			_objects.add(_bullets);
			//_objects.add(_enemies);
			
		}

		override public function update():void
		{
			//superclass member ( FlxState  )
			// Automatically goes through and calls update on everything you added.
			super.update();
			
			_timer += FlxG.elapsed;
			
			FlxG.collide(_blocks, _objects, collided);
			FlxG.overlap(_enemies, _player, overlapped);
			FlxG.overlap(_enemies, _bullets, overlapped);
			
			if (!_player.alive)
			{
				FlxG.score = 0;
			}
			_score.text = FlxG.score.toString();
			
			if (_enemies.countLiving() <= 0)
			{
				FlxG.fade(0xffd8eba2, 3);
			}
			if (FlxG.score == 0)
			{
				_player.kill
				FlxG.fade(0xffaa1111, 3);
			}
		}


		protected function generateLevel():void
		{

			for (var i:int = 0; i < 6; i++)
			{
				var tile:FlxTileblock;
				tile = new FlxTileblock(80 + (20*i),110,20,20);
				tile.loadTiles(Imgtile, 20, 20);
				tile.solid = true;
				_blocks.add(tile);
			}		

			for (var i:int = 0; i < 3; i++)
			{
				var tile:FlxTileblock;
				tile = new FlxTileblock(60 + (20*i),50,20,20);
				tile.loadTiles(Imgtile, 20, 20);
				tile.solid = true;
				_blocks.add(tile);
			}		
			
			for (var i:int = 0; i < 2; i++)
			{
				var tile:FlxTileblock;
				tile = new FlxTileblock(200 + (20*i),50,20,20);
				tile.loadTiles(Imgtile, 20, 20);
				tile.solid = true;
				_blocks.add(tile);
			}
			
			
			var ceiling:FlxTileblock;
			ceiling = new FlxTileblock(0, 0, 640, 5);
			_blocks.add(ceiling);
		
			var floor:FlxTileblock;
			floor = new FlxTileblock(0, 165, 640, 5);
			_blocks.add(floor);
			
			var wall:FlxTileblock;
			wall = new FlxTileblock(295, 0, 5, 1080);
			_blocks.add(wall);
			
			var wall:FlxTileblock;
			wall = new FlxTileblock(0, 0, 5, 1080);
			_blocks.add(wall);
			
		}
		
		protected function overlapped(sprite1:FlxSprite, sprite2:FlxSprite):void
		{
			if (_timer > 1)
			{
				_timer = 0;
				if (sprite2 is Player)
					sprite2.hurt(1);
			}
			if(sprite2 is Bullet) 
			{
				sprite1.kill();
				sprite2.kill();
			}
		}
		
		protected function collided(sprite1:FlxSprite, sprite2:FlxSprite):void
		{
			if (sprite2 is Bullet)
				sprite2.kill();
		}
	}
}
