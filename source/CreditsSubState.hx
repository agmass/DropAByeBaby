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

class CreditsSubState extends FlxSubState
{
	var sprite:FlxSprite = new FlxSprite(0, 0);
	var agicon:FlxSprite = new FlxSprite(0, 0, AssetPaths.agmas__png);
	var agtext:FlxText = new FlxText(0, 0, 0, "agmas [Code, Music]", 16);
	var blicon:FlxSprite = new FlxSprite(0, 0, AssetPaths.blumanje__png);
	var bltext:FlxText = new FlxText(0, 0, 0, "blumaanj [Art (and lots of explosions)]", 16);
	var swicon:FlxSprite = new FlxSprite(0, 0, AssetPaths.sw__png);
	var swtext:FlxText = new FlxText(0, 0, 0, "S w e d e [Uhh.. Mental support?]", 16);

	override public function create():Void
	{
		sprite.makeGraphic(Math.round(FlxG.width / 2), Math.round(FlxG.height / 2), FlxColor.GRAY);
		sprite.screenCenter();
		sprite.alpha = 0;
		FlxTween.tween(sprite, {alpha: 1}, 0.5);
		add(sprite);
		agtext.screenCenter();
		agtext.y -= 64;
		agtext.alpha = 0;
		FlxTween.tween(agtext, {alpha: 1}, 0.5);
		add(agtext);
		agicon.screenCenter();
		agicon.y -= 64;
		agicon.x = agtext.x - 64;
		add(agicon);
		agicon.alpha = 0;
		FlxTween.tween(agicon, {alpha: 1}, 0.5);

		bltext.screenCenter();
		bltext.alpha = 0;
		FlxTween.tween(bltext, {alpha: 1}, 0.5);
		add(bltext);
		blicon.screenCenter();
		blicon.x = bltext.x - 64;
		add(blicon);
		blicon.alpha = 0;
		FlxTween.tween(blicon, {alpha: 1}, 0.5);

		swtext.screenCenter();
		swtext.y += 64;
		swtext.alpha = 0;
		FlxTween.tween(swtext, {alpha: 1}, 0.5);
		add(swtext);
		swicon.screenCenter();
		swicon.y += 64;
		swicon.x = swtext.x - 64;
		add(swicon);
		swicon.alpha = 0;
		FlxTween.tween(swicon, {alpha: 1}, 0.5);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.pressed.ESCAPE || FlxG.keys.pressed.ENTER)
		{
			FlxG.sound.play(AssetPaths.sound__wav);
			close();
		}
		super.update(elapsed);
	}
}
