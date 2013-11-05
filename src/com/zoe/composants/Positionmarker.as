package com.zoe.composants
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	
	public class Positionmarker extends flash.display.Sprite
	{
		private var zimgs:Array;				
		private var tick:uint;
		private var zbg:Quad;
		private var zt:Timer;

		public function Positionmarker()
		{
			super();
			zt=new Timer(70);
			zt.addEventListener(TimerEvent.TIMER,declenche);

			var xx:flash.display.Sprite=new flash.display.Sprite();
			xx.graphics.beginFill(0xFFB600);
			xx.graphics.drawCircle(10,10,10);
			xx.graphics.endFill();
			
			var u:BitmapData=new BitmapData(20,20,true,0xFFFFFF);
			u.draw(xx);
			zimgs=new Array();
			var ztxt:Texture=Texture.fromBitmapData(u);
			for (var j:uint=0;j<12;j++){
				var unrond:Sprite=new Sprite();
				unrond.graphics.beginFill(0xFF0000,1);
				unrond.graphics.drawCircle(10,10,20);
				unrond.graphics.endFill();
//				var zimg:Image=new Image(ztxt);
				addChild(unrond);
				unrond.scaleX=unrond.scaleY=j/12;
				unrond.alpha=j/12;
				unrond.x=40*Math.cos(j*Math.PI/6);
				unrond.y=40*Math.sin(j*Math.PI/6);
				zimgs.push(unrond);
			}			
		}
		private function declenche(zev:TimerEvent):void{
			tick=tick+1;
			for (var j:uint=0;j<zimgs.length;j++){
				zimgs[j].x=40*Math.cos((tick+j)*Math.PI/6);
				zimgs[j].y=40*Math.sin((tick+j)*Math.PI/6);
			}				
		}
		public function start():void{
			zt.start();			
		}
		public function stop():void{
			zt.stop();
			var zz:Tween=new Tween(this,0.5);
			zz.fadeTo(0);
			
			zz.onComplete=stopper;
			Starling.juggler.add(zz);
//			visible=false;
		}
		public function stopper():void{
			visible=false;
			alpha=1;
		}
	}
}