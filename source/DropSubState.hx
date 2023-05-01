package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.plugin.taskManager.FlxTask;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class DropSubState extends FlxSubState
{
	var uiCam:FlxCamera;
	var sprite:FlxSprite = new FlxSprite(0, 0);
	var player:FlxSprite = new FlxSprite(FlxG.width, 64);
	var hitOrMiss:FlxText = new FlxText(0, 0, 0, "Miss!", 32);

	public static var isSuccessful:Bool = false;

	override public function create():Void
	{
		uiCam = new FlxCamera(0, 0);
		sprite.loadGraphic(AssetPaths.bg__png);
		sprite.camera = uiCam;
		player.loadGraphic(AssetPaths.birdside__png, true, 32, 32);
		player.animation.add("baby", [0], 1, true);
		player.animation.add("nobaby", [1], 1, true);
		player.camera = uiCam;
		player.animation.play("baby");
		add(sprite);
		add(player);
		hitOrMiss.text = isSuccessful ? "Hit!" : "Miss..";
		hitOrMiss.color = isSuccessful ? FlxColor.GREEN : FlxColor.RED;
		hitOrMiss.setBorderStyle(FlxTextBorderStyle.OUTLINE_FAST, FlxColor.BLACK, 1);
		hitOrMiss.camera = uiCam;
		add(hitOrMiss);
		hitOrMiss.alpha = 0;
		hitOrMiss.scale.set(0, 0);
		uiCam.bgColor.alpha = 0;
		FlxG.cameras.add(uiCam);
		uiCam.alpha = 0;
		FlxTween.tween(uiCam, {alpha: 0.975}, 0.15);
		FlxTween.tween(player, {y: player.y - 32}, 1.5, {ease: FlxEase.sineIn, type: PINGPONG});
		new FlxTimer().start(0.15, function(tmr)
		{
			if (isSuccessful)
			{
				new FlxTimer().start(1.25, function(tmr)
				{
					throwDatBaby();
					FlxG.sound.play(AssetPaths.explosion__wav);
				});
			}
			if (!isSuccessful)
			{
				new FlxTimer().start(0.5, function(tmr)
				{
					FlxG.sound.play(AssetPaths.explosion__wav);
					throwDatBaby();
				});
			}
			FlxTween.tween(player, {x: -32}, 2);
			new FlxTimer().start(2.5, function(tmr)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.music.resume();
				close();
				PlayState.FuckYouTimer = false;
			});
		});
		super.create();
	}

	public function throwDatBaby()
	{
		if (PlayState.time <= 0)
		{
			PlayState.eventqueue.push("win");
		}
		if (PlayState.time == 90)
		{
			PlayState.eventqueue.push("afternoon");
		}
		if (PlayState.time == 60)
		{
			PlayState.eventqueue.push("night");
		}
		if (PlayState.time == 30)
		{
			PlayState.eventqueue.push("final");
		}
		var baby:FlxSprite = new FlxSprite(player.x, player.y);
		player.animation.play("nobaby", true);
		baby.loadGraphic(AssetPaths.THEBABYE__png, true, 16, 16);
		baby.scale.set(2, 2);
		baby.animation.add("Wee", [0], 1, true);
		baby.animation.add("smash", [1], 1, true);
		baby.animation.add("grave", [2, 3, 4, 5, 6, 7, 8, 9], 8, false);
		baby.animation.play("Wee", true);
		add(baby);
		baby.camera = uiCam;
		FlxTween.tween(baby, {angle: 359}, 0.25);
		FlxTween.tween(baby, {y: 678 - baby.height}, 0.25, {
			onComplete: function(twn)
			{
				baby.angle = 0;
				baby.animation.play("smash", true);
				if (!isSuccessful)
				{
					baby.animation.play("grave", true);
					PlayState.FuckYouTimer = true;
					FlxG.sound.music.pause();
					FlxG.sound.play(AssetPaths.expl__wav);
				}
				else
				{
					FlxG.sound.play(AssetPaths.good__wav);
				}
				hitOrMiss.scale.set(0, 0);
				FlxTween.tween(hitOrMiss, {"scale.x": 2.5, "scale.y": 2.5, alpha: 1}, 0.25, {ease: FlxEase.elasticInOut});
			}
		});
	}

	override public function update(elapsed:Float):Void
	{
		hitOrMiss.screenCenter();
		super.update(elapsed);
	}
}
