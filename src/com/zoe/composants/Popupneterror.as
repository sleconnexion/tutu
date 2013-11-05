package com.zoe.composants
{
	import flash.desktop.NativeApplication;
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class Popupneterror extends Sprite
	{
		private var zimgs:Array;				
		private var tick:uint;
		private var zbg:Quad;
		
		public function Popupneterror(ztype:uint)
		{
			super();
			zbg=new Quad(1,1,Color.BLACK,true);
//			zbg.alpha=0.7;
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("fondorange"),new Rectangle(70,70,40,10));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			
			switch (ztype){
				case 1 :
					trace("popupneterror cas 1");
					var zlab1:Label=new Label();
					zlab1.nameList.add(ZoeMobileTheme.POPUNET_TITRE1);				
					zlab1.text="Bouhh !!! Pas de réseau";
					addChild(zlab1);
					
					var zlab2:Label=new Label();
					zlab2.nameList.add(ZoeMobileTheme.POPUNET_TITRE2);
					zlab2.text="Aucune connexion internet active n’est disponible (EDGE, 3/4G ou wifi).";
					addChild(zlab2);

					var zlab3:Label=new Label();
					zlab3.nameList.add(ZoeMobileTheme.POPUNET_TITRE2);
					zlab3.text="Veuillez vous connecter à un réseau et relancer RueCentrale.";
					addChild(zlab3);

					var btnquitter:Button=new Button();
					btnquitter.nameList.add(ZoeMobileTheme.POPUPNET_BTN);
					btnquitter.label="Quitter";
					btnquitter.width=120;
					btnquitter.height=40;
					btnquitter.addEventListener(starling.events.Event.TRIGGERED, btnquitter_triggeredHandler);
					addChild(btnquitter);			

					uneimg.height=300;
					uneimg.width=200;

					zlab1.width=uneimg.width;
					zlab1.y=20;
					zlab2.width=uneimg.width;
					zlab2.y=90;
					zlab3.width=uneimg.width;
					zlab3.y=150;
					
					btnquitter.y=220;
					btnquitter.x=uneimg.width/2 -btnquitter.width/2;
					
					break;
				
			}
			
			x=50;
			y=50;
		}
		private function btnquitter_triggeredHandler(event:starling.events.Event):void
		{
			trace("quitter appli");
			NativeApplication.nativeApplication.exit();
		}

		public function setsize(zw:uint,zh:uint) :void{
			zbg.width=zw;
			zbg.height=zh;
			
		}
	}
}

