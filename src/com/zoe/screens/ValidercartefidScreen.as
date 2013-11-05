package com.zoe.screens
{
	import com.adobe.crypto.MD5;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]
	[Event(name="cartebloqueescreen",type="starling.events.Event")]
	
	public class ValidercartefidScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var _container:ScrollContainer;
		
		private var _labderniereadresse:Label;
		private var _labm:Label;
		
		
		private var _codesecret:Label;
		private var _lecodesecret:String;
		
		private var _laberror:Label;
		
		public function ValidercartefidScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("Identification initialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK,true);
			q.alpha=0.7;
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);

			// zone du milieu
			_iconmsg=new Image(Root.assets.getTexture("pictoadresse"));
//			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="S'identifier";
//			addChild(_labelico);
			
			_container=new ScrollContainer();
			_container.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("fondorange"),new Rectangle(70,70,40,10)));
			var vl:VerticalLayout=new VerticalLayout();
			vl.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			_container.layout=vl;
			vl.paddingTop=20;
			vl.gap=0;
			addChild(_container);
			
			
			
			var labhaut:Label=new Label();
			labhaut.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABHAUT);
			labhaut.text="Pour valider cet achat, demandez à votre commerçant d'entrer son code secret à 4 chiffres ci-dessous";
			_container.addChild(labhaut);
			labhaut.width=240;
			
			
			var sp:ScrollContainer=new ScrollContainer();
			
			var img:Scale9Image=new Scale9Image(new Scale9Textures(Root.assets.getTexture("zonesaisie"),new Rectangle(10,10,80,5)));
			sp.backgroundSkin=img;
			
			_laberror=new Label();
			_laberror.nameList.add(ZoeMobileTheme.CARTEFIDERROR);
			_container.addChild(_laberror);
			_laberror.text=" ";
//			_laberror.height=14;
			_laberror.width=200;
			
			_codesecret= new Label();
			_codesecret.nameList.add(ZoeMobileTheme.CARTEFIDVALIDESECRET);
			_lecodesecret="";
			_codesecret.text=_lecodesecret;
			_codesecret.width=80;
			_codesecret.height=20;
			sp.addChild(_codesecret);
			
			_container.addChild(sp);

						
			var qq7:Quad=new Quad(1,2,0xFFB600);
			_container.addChild(qq7);
			
			
			// le clavier
			var clavier:ScrollContainer=new ScrollContainer();
			
			var htl:TiledRowsLayout=new TiledRowsLayout();
			
			clavier.layout=htl;
			htl.paddingLeft=10;
			htl.paddingRight=10;
			//					hl.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			htl.paddingTop=10;
			htl.paddingBottom=10;
			htl.gap=5;
			htl.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			clavier.width=220;
			_container.addChild(clavier);
			for(var i:int=1;i<10;i++){
				trace("ajout du tampon "+i);
					var btnchiffre:Button=new Button();
					btnchiffre.width=50;
					btnchiffre.height=51;
					btnchiffre.nameList.add(ZoeMobileTheme.CARTEFIDCLAVIER);
					btnchiffre.label=""+i;
					clavier.addChild(btnchiffre);
					btnchiffre.addEventListener(starling.events.Event.TRIGGERED,btnchiffreButton_triggeredHandler);
			}
			var btncorr:Button=new Button();
			btncorr.width=50;
			btncorr.height=51;
			btncorr.nameList.add(ZoeMobileTheme.CARTEFIDCLAVIERC);
			btncorr.label="corr.";
			var btnchiffre0:Button=new Button();
			btnchiffre0.width=50;
			btnchiffre0.height=51;
			btnchiffre0.nameList.add(ZoeMobileTheme.CARTEFIDCLAVIER);
			btnchiffre0.label="0";
			btnchiffre0.addEventListener(starling.events.Event.TRIGGERED,btnchiffreButton_triggeredHandler);
			clavier.addChild(new Quad(50,51,0xFFB600));
			clavier.addChild(btnchiffre0);
			clavier.addChild(btncorr);
			btncorr.addEventListener(starling.events.Event.TRIGGERED,btncorrButton_triggeredHandler);
			
			_container.addChild(new Quad(1,10,0xFFB600));
			var btncree:Button=new Button();
			btncree.nameList.add(ZoeMobileTheme.IDENTIFICATIONBTNNOIR);
			btncree.label="Validation commerçant";
			btncree.width=160;
			btncree.addEventListener(starling.events.Event.TRIGGERED, btnvaliderButton_triggeredHandler);
			_container.addChild(btncree);
		}
		override protected function draw():void
		{
			trace("draw message");
			_backButton.x=5;
			_backButton.y=5;
			
			_iconmsg.x=100;
			_iconmsg.y=10;
			
			_labelico.x=_iconmsg.x+30;
			_labelico.y=10;
			_labelico.width=200;
			
			_container.y=40;
			_container.width=260;
			_container.x=(this.actualWidth-_container.width)/2;
			_container.height=430;
		}
		
		private function valider():void{
			trace("appel de valider");
			if(_lecodesecret.length!=4){
				_laberror.text="Saisissez 4 chiffres";
				return;
			}
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onError);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonvalidtampon?rnd="+Math.random());
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zdata.idshop=partie.idshop;
			zdata.code=_lecodesecret;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			trace("Recup du post");
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			var autreadre:Boolean=false;
			trace("zret.ok=>"+zret.ok);
			_laberror.text=" ";

			switch (zret.ok){
				case 1:
					trace("cas 1");
					this.dispatchEventWith(starling.events.Event.COMPLETE);
					break;
				case 2:
					// erreur sur le formulaire
					_laberror.text=zret.error;
					_lecodesecret="";
					_codesecret.text="";
					break;
				case 3:
					//carte bloque
					partie.datebloque=zret.DATEBLOQUE;
					this.dispatchEventWith("cartebloqueescreen");
					break;
				default:
					// erreur technique afficher la popup de pb technique
					// todo
					break;
			}
		}
		private function onBackButton():void
		{
			trace("bacckbutton");
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		
		private function btnchiffreButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click sidetifier");
			var btn:Button=event.currentTarget as Button;
			_lecodesecret=_lecodesecret+btn.label;
			_codesecret.text=_codesecret.text+"*";
			trace("code=>"+_lecodesecret);
		}
		private function btncorrButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click corr");
			if(_lecodesecret.length>0){
				_lecodesecret=_lecodesecret.slice(0,_lecodesecret.length-1);
				_codesecret.text=_codesecret.text.slice(0,_codesecret.text.length-1);
			}
			trace("code=>"+_lecodesecret);
		}
		private function btnvaliderButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			valider();
		}
		private function backButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.onBackButton();
		}

		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
	}
}