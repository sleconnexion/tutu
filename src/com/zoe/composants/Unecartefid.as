package com.zoe.composants
{
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	[Event(name="menumsg",type="starling.events.Event")]

	public class Unecartefid extends starling.display.Sprite
	{
		private var leshop:Object;
		private const HAUTEUR:uint=115;
		private var _nomshop:Label;
		public function Unecartefid(zshop:Object)
		{
			super();
			// represente la popup de menu, sous forme d un sprite
			leshop=zshop;
			init();
		}
		private function init():void{
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("fondblanc"),new Rectangle(0,15,300,5));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			addChild(uneimg);
			uneimg.height=HAUTEUR;
			uneimg.width=300;

			_nomshop=new Label();
			_nomshop.nameList.add(ZoeMobileTheme.ACTULABELNOMSHOP);
			_nomshop.text=leshop.NOMSHOP;
			_nomshop.x=10;
			_nomshop.width=280;
			_nomshop.y=20;
			addChild(_nomshop);
			
			var icone:ImageLoader = new ImageLoader();
			if(leshop.AVATAR){
				icone.source = "https://bucketzoe.s3.amazonaws.com/shoppic/"+leshop.AVATAR;
			} else {
				icone.source = "https://bucketzoe.s3.amazonaws.com/avatar/images.jpg";
			}
			icone.x=8;
			icone.y=50;
			icone.width=55;
			icone.height=55;
			this.addChild(icone);
			
					
			var sczonegauche:ScrollContainer=new ScrollContainer();

			var lygv:VerticalLayout=new VerticalLayout();
			sczonegauche.layout=lygv;
			sczonegauche.horizontalScrollPolicy=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			sczonegauche.width=220;
			addChild(sczonegauche);
			sczonegauche.x=70;
			sczonegauche.y=50;
			
			//categorie
			var _labcateg:Label=new Label();
			_labcateg.nameList.add(ZoeMobileTheme.CARTEFIDTYPE);
			_labcateg.text=leshop.TYPECOMMERCELIB;
			_labcateg.width=190;
			sczonegauche.addChild(_labcateg);
			
			
			var scrimg:ScrollContainer=new ScrollContainer();
//			scrimg.width=100;
			
			var hli:HorizontalLayout=new HorizontalLayout();
			scrimg.layout=hli;
			hli.gap=10;
			sczonegauche.addChild(scrimg);

			var _imgcateg1:Image=new Image(Root.assets.getTexture("cartefid"));

			var labvoir:Label=new Label();
			labvoir.nameList.add(ZoeMobileTheme.CARTEFIDVOIR);
			labvoir.text="voir la carte de fidélité";
//			_labadresse.width=200;
			
			var btnchevron:Button=new Button();
			btnchevron.nameList.add(ZoeMobileTheme.COMMONBTNCHEVRON);
			
			btnchevron.addEventListener(starling.events.Event.TRIGGERED,onclickchevron);
			
			scrimg.addChild(_imgcateg1);
			scrimg.addChild(labvoir);
			scrimg.addChild(btnchevron);
			
			
//			addEventListener(TouchEvent.TOUCH,onTouchbtn);
		}
		public function filtrer(ztitre:String):void{
			if(_nomshop.text.toLowerCase().match(ztitre.toLowerCase())){
				rendrevisible();
			} else {
				rendreinvisible();
			}
		}
		private function rendreinvisible():void{
			var tweenf:Tween=new Tween(this,0.2,Transitions.LINEAR);
			tweenf.animate("height",0);
			Starling.juggler.add(tweenf);
		}
		private function rendrevisible():void{
			var tweenf:Tween=new Tween(this,0.2,Transitions.LINEAR);
			tweenf.animate("height",HAUTEUR);
			Starling.juggler.add(tweenf);		
		}
		private function onclickchevron(e:Event):void
		{
			// position de la foche et acces à la fiche co
			Root.partie.idshop=leshop.IDSHOP;
			Root.partie.nomshop=leshop.NOMSHOP;
			Root.partie.fromscreen=Root.MESCARTEFIDS_SCREEN;
			this.dispatchEventWith(Root.CARTEFID_SCREEN,true);
		}
	}
}