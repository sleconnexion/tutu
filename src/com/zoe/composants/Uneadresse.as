package com.zoe.composants
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PickerList;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Uneadresse extends starling.display.Sprite
	{
		public static const MAISON:String="MAISON";
		public static const BUREAU:String="BUREAU";
		
		private var ladresse:Object;
		private var letype:String;
		public function Uneadresse(zadresse:Object,ztype:String)
		{
			super();
			ladresse=zadresse;
			letype=ztype;
			switch (letype){
				case MAISON:
					init("maison","Maison");
					break;
				case BUREAU:
					init("bureau","Bureau");
					break;
				default:
					initlite();
					break;
			}
			
		}
		private function init(zpicto:String,zlib:String):void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("fondblanc"),new Rectangle(0,10,300,5));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=70;
			uneimg.width=300;

			var imgpicto:Image=new Image(Root.assets.getTexture(zpicto));
			imgpicto.x=10;
			imgpicto.y=25;
			addChild(imgpicto);
			
			var lablib:Label=new Label();
			lablib.nameList.add(ZoeMobileTheme.MESADRESSESTITRE);
			lablib.text=zlib;
			lablib.x=40;
			lablib.width=150;
			lablib.y=20;
			addChild(lablib);
			
			if(ladresse){
				var labadr:Label=new Label();
				labadr.nameList.add(ZoeMobileTheme.MESADRESSESLIB);
				labadr.text=ladresse.ADRESSELIB;
				labadr.x=40;
				labadr.width=150;
				labadr.y=40;
				addChild(labadr);

				var imgloupe:Image=new Image(Root.assets.getTexture("loupeblanc"));
				imgloupe.x=260;
				imgloupe.y=30;
				addChild(imgloupe);
				imgloupe.addEventListener(TouchEvent.TOUCH,onTouchco);				
				//			addEventListener(TouchEvent.TOUCH,onTouchbtn);

			} else {
				var labadrvide:Label=new Label();
				labadrvide.nameList.add(ZoeMobileTheme.MESADRESSESLIBVIDE);
				labadrvide.text="Cliquer ici pour saisir l'adresse";
				labadrvide.x=40;
				labadrvide.width=170;
				labadrvide.y=40;
				addChild(labadrvide);
				addEventListener(TouchEvent.TOUCH,onTouchvide)
			}
		}
		
		private function initlite():void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("fondblanc"),new Rectangle(0,10,300,5));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=60;
			uneimg.width=300;
			
			var imgpicto:Image=new Image(Root.assets.getTexture("carte"));
			imgpicto.x=10;
			imgpicto.y=25;
			addChild(imgpicto);
			
			var lablib:Label=new Label();
			lablib.nameList.add(ZoeMobileTheme.MESADRESSESLIB);
			lablib.text=ladresse.ADRESSELIB;
			lablib.x=40;
			lablib.width=150;
			lablib.y=20;
			addChild(lablib);
			
			var imgloupe:Image=new Image(Root.assets.getTexture("loupeblanc"));
			imgloupe.x=260;
			imgloupe.y=25;
			addChild(imgloupe);
			imgloupe.addEventListener(TouchEvent.TOUCH,onTouchco);				
			//			addEventListener(TouchEvent.TOUCH,onTouchbtn);	
		}
		
		private function onTouchco(e:TouchEvent):void
		{
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			
			Root.partie.typedata="2";
			// mettre lat et lng ds partie
			// avertir la carto
			Root.partie.carto.loadURL("javascript:majadresse("+ladresse.LAT+","+ladresse.LNG+");");

			Root.ouvrircarto();
			this.dispatchEventWith("complete",true);
			
			// position de la foche et acces à la fiche co
//			Root.partie.idshop=leshop.IDSHOP;
//			Root.partie.fromscreen=Root.MESCOMERCANTS_SCREEN;
//			this.dispatchEventWith(Root.FICHECO_SCREEN,true);
		}
		private function onTouchvide(e:TouchEvent):void
		{
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			trace("Saisir vide");
			switch (letype){
				case MAISON:
					Root.partie.typedata="0";
					break;
				case BUREAU:
					Root.partie.typedata="1";
					break;
				default:
					Root.partie.typedata="2";
					break;
			}

			this.dispatchEventWith(Root.SAISIRADRESSE_SCREEN,true);
		}
	}
}