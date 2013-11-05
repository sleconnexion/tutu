package com.zoe.composants
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Boutonfiltre extends starling.display.Sprite
	{
		private var lid:uint;
		private var lelib:String;
		private var imgfond:Image;
		public function Boutonfiltre(zint:uint,zlib:String,zsel:String)
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			lid=zint;
			lelib=zlib;
			init(zint,zlib,zsel);
		}
		private function init(zint:uint,zlib:String,zsel:String):void{
			//var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("btnblanc"),new Rectangle(10,5,55,10));
			//var uneimg:Scale9Image=new Scale9Image(bgt);
			imgfond=new Image(Root.assets.getTexture("btncarreblancpictoon"));
			addChild(imgfond);
			if(zsel=="0"){
				imgfond.alpha=0.5;
			}
			//uneimg.height=65;
			//uneimg.width=65;
			majtype(zint,zlib);
			addEventListener(TouchEvent.TOUCH,onTouchbtn);
		}
		public function issel():Boolean{
			return (imgfond.alpha==1);
		}
		private function onTouchbtn(e:TouchEvent):void
		{
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			// recup du btn
			trace("touch btn:"+lid);
			// maj du tableau incicateur
			if(imgfond.alpha==1){
				imgfond.alpha=0.5;				
			} else {
				imgfond.alpha=1;
			}
			// maj du tableau
		}

		
		public function majtype(zint:uint,zlib:String):void{
			var icoadresse:Image=new Image(Root.assets.getTexture(""+zint));			
			icoadresse.x=15;
			icoadresse.y=2;
			var zlabadr:Label=new Label();
			zlabadr.nameList.add(ZoeMobileTheme.BOUTONMENU_TITRE);
			zlabadr.text="\n"+zlib;
			zlabadr.x=0;//-12;
			zlabadr.y=20;
			zlabadr.width=65;
			addChild(icoadresse);
			addChild(zlabadr);
		}
		public function majicon(ztext:String):void{
			
		}
	}
}