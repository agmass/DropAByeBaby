package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{
	public var SPEED:Float = 250;
	public var SUPERSPEEEED:Float = 0;
	public var face:Float = 0;

	var superAngle:Int = 0;
	var particleEmitDelay:Float = 100;

	public var particles:FlxEmitter;
	public var stamina:Float = 100;
	public var staminaBar:FlxBar = new FlxBar(-100, -100, FlxBarFillDirection.LEFT_TO_RIGHT, 64, 10);

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		drag.x = drag.y = 300;
		particles = new FlxEmitter(0, 0, 250);
		particles.makeParticles(4, 4, FlxColor.WHITE, 1000);
		particles.lifespan.set(0.5, 0.75);
		loadGraphic(AssetPaths.bird__png, true, 32, 32);
		animation.add("glide", [0, 1, 2, 3, 4, 5], 6, true);
		animation.add("kaboom", [6, 7, 8, 9, 10, 11, 12, 13, 14], 10, false);
		animation.add("flap", [15, 16, 17, 18, 19], 10, false);
		animation.add("hurt", [20, 21, 22], 9, false);
		color = FlxColor.WHITE;
		new FlxTimer().start(0.0166666667, function delay(tmr:FlxTimer)
		{
			if (stamina != 100)
			{
				stamina += 2 + SPEED / 10000;
			}
		}, 0);
	}

	override function update(elapsed:Float)
	{
		if (scale.x >= 0.5)
		{
			if (animation.finished)
				animation.play("glide", false);
			staminaBar.value = stamina;

			if (stamina != 100)
			{
				if (staminaBar.alpha == 0)
				{
					FlxTween.tween(staminaBar, {alpha: 1}, 0.1);
				}
			}
			if (stamina >= 100 && staminaBar.alpha == 1)
			{
				stamina = 100;
				FlxTween.tween(staminaBar, {alpha: 0}, 0.1);
			}
			var up:Bool = false;
			var down:Bool = false;
			var left:Bool = false;
			var right:Bool = false;
			up = FlxG.keys.anyPressed([UP, W]);
			down = FlxG.keys.anyPressed([DOWN, S]);
			left = FlxG.keys.anyPressed([LEFT, A]);
			right = FlxG.keys.anyPressed([RIGHT, D]);
			if (SPEED >= 400)
			{
				FlxG.camera.shake(SPEED / 800000, 0.1);
			}
			if (FlxG.keys.justPressed.SPACE && stamina >= 100 && SPEED >= 250)
			{
				animation.play("flap", true);
				scale.y = 0.65;
				FlxTween.tween(scale, {y: 1}, 0.25);
				scale.x = 1;
				FlxG.camera.shake(0.005, 0.25);
				particles.alpha.set(1, 1, 0, 0);
				particles.color.set(FlxColor.fromRGB(0, 183, 233));
				FlxG.sound.play(AssetPaths.explosion__wav, 1);
				particles.start(true, 0.01, Std.int(SPEED / 100));
				SPEED += 25;
				SUPERSPEEEED = 100;
				particleEmitDelay = 150;
				stamina = 0;
			}
			if (SUPERSPEEEED > 0)
			{
				SUPERSPEEEED -= 1;
			}
			particleEmitDelay -= 100 * (SUPERSPEEEED / 100);
			var coolColor:FlxColor = FlxColor.WHITE;
			if (SPEED >= 650)
			{
				coolColor = FlxColor.YELLOW;
			}
			if (SUPERSPEEEED >= 1 && particleEmitDelay <= 0)
			{
				particleEmitDelay = 100;
				particles.color.set(coolColor);
				particles.alpha.set(SUPERSPEEEED / 100, SUPERSPEEEED / 100, 0, 0);
				particles.start(true, 0.0005, 1);
			}

			if (up && down)
				up = down = false;
			if (left && right)
				left = right = false;
			if (up || down || left || right)
			{
				SPEED += 0.25;
				velocity.x = SPEED;
				velocity.y = SPEED;
				var newAngle:Float = 0;
				if (up)
				{
					newAngle = -90;
					superAngle = -90;
					if (left)
						newAngle -= 45;
					else if (right)
						newAngle += 45;
				}
				else if (down)
				{
					superAngle = 90;
					newAngle = 90;
					if (left)
						newAngle += 45;
					else if (right)
						newAngle -= 45;
				}
				else if (left)
				{
					superAngle = 180;
					newAngle = 180;
				}
				else if (right)
				{
					superAngle = 0;
					newAngle = 0;
				}
				face = newAngle;
				angle = newAngle + 90;
				velocity.setPolarDegrees(SPEED + (SUPERSPEEEED * 4), newAngle);
			}
			else
			{
				SPEED -= 5;
				if (SPEED < 250)
				{
					SPEED = 250;
				}
			}
			if (SPEED < 250)
			{
				stamina = 0;
				SPEED += 40;
			}
			scale.x -= 0.005;
			scale.y = scale.x;
			staminaBar.x = x - 16;
			staminaBar.y = y - 16;
			particles.x = x + 16;
			particles.y = y + 16;
		}
		super.update(elapsed);
	}
}
