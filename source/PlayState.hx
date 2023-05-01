package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var gameCam:FlxCamera;
	var buildings:FlxSpriteGroup = new FlxSpriteGroup(0, 0);
	var uiCam:FlxCamera;
	var warning:FlxSprite = new FlxSprite(0, 0, AssetPaths.exclaim__png);
	var toTarget:FlxSprite = null;
	var timer:FlxText = new FlxText(FlxG.width / 2, 10, 0, "2:00", 32);
	var points:FlxText = new FlxText(FlxG.width / 2, 10, 0, "0 Hits", 16);

	public static var time:Int = 60 * 2;

	var loadbirb:FlxSprite = new FlxSprite(0, 0, AssetPaths.loadbirb__png);

	var overlay:FlxSprite = new FlxSprite(0, 0);

	public static var eventqueue:Array<String> = [];

	public static var FuckYouTimer:Bool = false;

	public static var hits:Int = 0;

	override public function create()
	{
		eventqueue = [];
		time = 35;
		FuckYouTimer = false;
		hits = 0;
		FlxG.sound.music = new FlxSound();
		FlxG.sound.music.loadEmbedded(AssetPaths.calmBeforeTheStorm__wav, true);
		FlxG.sound.music.play();
		gameCam = new FlxCamera();
		map = new FlxOgmo3Loader(AssetPaths.DABB__ogmo, AssetPaths.lvl__json);
		walls = map.loadTilemap(AssetPaths.tilemap__png, "roads");
		buildings.camera = gameCam;
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.camera = gameCam;
		for (i in 2...9)
		{
			walls.setTileProperties(i, ANY);
		}
		for (i in 10...37)
		{
			walls.setTileProperties(i, NONE);
		}
		walls.setTileProperties(38, NONE);
		add(walls);
		map.loadEntities(placeEntities, "builds");
		add(buildings);
		player = new Player(1504, 832);
		add(player);
		timer.color = FlxColor.GREEN;
		add(player.staminaBar);
		add(player.particles);
		player.camera = gameCam;
		player.staminaBar.camera = gameCam;
		player.particles.camera = gameCam;
		uiCam = new FlxCamera(0, 0);
		uiCam.bgColor.alpha = 0;
		warning.camera = gameCam;
		timer.camera = uiCam;
		points.camera = uiCam;
		add(timer);
		add(points);
		add(warning);
		FlxG.cameras.reset(gameCam);
		FlxG.cameras.add(uiCam);
		FlxG.camera.zoom = 1.75;
		FlxG.camera.fade(FlxColor.BLACK, 0.25, true);
		FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN_TIGHT, 2.5);
		new FlxTimer().start(1, function(tmr)
		{
			if (overlay.alpha == 1)
			{
				overlay.alpha = 0.35;
				time = 30;
				FlxG.sound.music.play();
				loadbirb.alpha = 0;
			}
			if (!FuckYouTimer)
			{
				time--;
				var num:String = "" + FlxMath.wrap(time, 0, 60);
				if (Std.parseInt(num) < 10)
				{
					num = "0" + num;
				}
				timer.text = Math.floor(time / 60) + ":" + num;
				if (time <= 0)
				{
					eventqueue.push("win");
				}
				if (time == 90)
				{
					eventqueue.push("afternoon");
				}
				if (time == 60)
				{
					eventqueue.push("night");
				}
				if (time <= 30 && overlay.color != FlxColor.BLACK)
				{
					eventqueue.push("final");
				}
				if (eventqueue.contains("win"))
				{
					eventqueue.remove("win");
					if (this.subState != null)
					{
						this.subState.close();
						this.subState.destroy();
					}
					FuckYouTimer = true;
					time = 0;
					FlxG.sound.music.fadeOut(1);
					var tempState:WinSubState = new WinSubState();
					openSubState(tempState);
				}
				if (eventqueue.contains("afternoon"))
				{
					eventqueue.remove("afternoon");
					overlay.color = FlxColor.ORANGE;
					FlxTween.tween(overlay, {alpha: 0.25}, 5);
				}
				if (eventqueue.contains("night"))
				{
					eventqueue.remove("night");
					overlay.color = FlxColor.PURPLE;
				}
				if (eventqueue.contains("final"))
				{
					eventqueue.remove("final");
					overlay.alpha = 1;
					loadbirb.alpha = 1;
					overlay.color = FlxColor.BLACK;
					timer.size = 64;
					timer.color = FlxColor.RED;
					FlxG.sound.music.stop();
					FlxG.sound.music.loadEmbedded(AssetPaths.winnersTune__wav, false);
				}
			}
		}, 0);
		resetTarget();
		overlay.makeGraphic(FlxG.width, FlxG.height);
		overlay.alpha = 0;
		overlay.camera = uiCam;
		add(overlay);
		loadbirb.alpha = 0;
		loadbirb.camera = uiCam;
		add(loadbirb);
		loadbirb.scale.set(4, 4);
		loadbirb.screenCenter();
		super.create();
	}

	public function resetTarget()
	{
		toTarget = buildings.getRandom();
	}

	override public function update(elapsed:Float)
	{
		if (overlay.alpha == 1)
		{
			player.scale.set(1.25, 1.25);
		}
		timer.screenCenter(X);
		points.screenCenter(X);
		points.y = timer.y + (timer.height + 8);
		if (player.scale.x < 0.5 && player.animation.name != "kaboom")
		{
			FlxG.sound.music.fadeOut(0.25);
			player.animation.play("kaboom", true);
			FlxG.sound.play(AssetPaths.expl__wav);
			player.velocity.set(0, 0);
			player.maxVelocity.set(0, 0);
			player.acceleration.set(0, 0);
			FlxG.camera.follow(null);
			FlxG.camera.scroll.x = (player.x + 16) - FlxG.width / 2;
			FlxG.camera.scroll.y = (player.y + 16) - FlxG.height / 2;
			FlxTween.tween(FlxG.camera, {zoom: 16}, 0.5, {ease: FlxEase.bounceOut});
			new FlxTimer().start(1, function(tmr)
			{
				var tempState:MenuSubState = new MenuSubState();
				openSubState(tempState);
			});
		}
		super.update(elapsed);
		points.text = hits + " Hits";
		if (FlxG.keys.justPressed.X)
		{
			DropSubState.isSuccessful = FlxG.overlap(player, toTarget);
			resetTarget();
			if (DropSubState.isSuccessful)
			{
				player.scale.x = 1;
				hits++;
			}
			else
			{
				time -= 5;
			}
			var tempState:DropSubState = new DropSubState();
			openSubState(tempState);
		}
		warning.x = FlxMath.bound(toTarget.x, FlxG.camera.scroll.x
			+ ((FlxG.width / 2) / 2),
			(FlxG.camera.scroll.x + FlxG.width)
			- ((FlxG.width / 2) / 2)
			- 64);
		warning.y = FlxMath.bound(toTarget.y, FlxG.camera.scroll.y
			+ ((FlxG.height / 2) / 2),
			(FlxG.camera.scroll.y + FlxG.height)
			- ((FlxG.height / 2) / 2)
			- 64);
		if (warning.x != toTarget.x || warning.y != toTarget.y)
		{
			if (toTarget.y > warning.y)
			{
				warning.angle = 180;
				if (toTarget.x > warning.x)
				{
					warning.angle -= 45;
				}
				if (toTarget.x < warning.x)
				{
					warning.angle += 45;
				}
			}
			else if (toTarget.y < warning.y)
			{
				warning.angle = 0;
				if (toTarget.x > warning.x)
				{
					warning.angle += 45;
				}
				if (toTarget.x < warning.x)
				{
					warning.angle -= 45;
				}
			}
			else if (toTarget.x > warning.x)
			{
				warning.angle = 90;
			}
			else if (toTarget.x < warning.x)
			{
				warning.angle = -90;
			}
		}
		else
		{
			warning.angle = 0;
		}
		FlxG.collide(player, walls, function(plr, wl)
		{
			if (player.SPEED + player.SUPERSPEEEED >= 300)
			{
				player.animation.play("hurt", true);
				player.SPEED = -player.SPEED;
				player.SUPERSPEEEED = 0;
				FlxG.camera.shake(0.005, 0.25);
				FlxG.sound.play(AssetPaths.hitHurt__wav, 1);
			}
		});
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "building")
		{
			var build:FlxSprite = new FlxSprite(entity.x, entity.y, AssetPaths.buildsprite__png);
			build.camera = gameCam;
			buildings.add(build);
		}
	}
}
