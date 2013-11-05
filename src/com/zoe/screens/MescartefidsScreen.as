package com.zoe.screens
{
	import com.zoe.composants.Homercloader;
	import com.zoe.composants.Unecartefid;
	import com.zoe.composants.Unshop;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]

	public class MescartefidsScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var container:ScrollContainer;
		private var _list:List;
		private var _textInput0:TextInput;
		private var _icorech:Image;
		private var _groceryList:ListCollection;

		private var rcl:Homercloader;
		private var _labelmsg:Label;

		public function MescartefidsScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("mescartefids initialize");
			Root.afficherbg();
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
			_iconmsg=new Image(Root.assets.getTexture("menupictofid"));
			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="Mes cartes de fidélité";
			addChild(_labelico);
						
						
			var layout:TiledRowsLayout= new TiledRowsLayout();
			layout.typicalItemHeight=200;
			container= new ScrollContainer()
			//container.layout = layout;
						
			var ll:VerticalLayout=new VerticalLayout();
			ll.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			ll.gap=10;
			container.layout=ll;
			
			addChild(container);
				
			rcl=new Homercloader();
			addChild(rcl);	
			rcl.start();
			_labelmsg=new Label();
			_labelmsg.nameList.add(ZoeMobileTheme.ROOT_LABPRG);
			addChild(_labelmsg);
			_labelmsg.text="Récupération de la \n liste de vos cartes de fidélité";
			
			container.visible=false;
			recupmescartes();
			
			// test
			/*
			var st:StageWebView=new StageWebView();
			st.loadURL("http://www9.noomiz.com/ruecentrale/chercheadresse/iduser/11");
			st.stage=Starling.current.nativeStage;
			st.viewPort=new Rectangle(0,30,300,300);
			*/
			
		}
		override protected function draw():void
		{
			trace("draw mescartesfid");
			_backButton.x=5;
			_backButton.y=5;
			
			_iconmsg.x=100;
			_iconmsg.y=10;
						
			_labelico.x=_iconmsg.x+30;
			_labelico.y=10;
			_labelico.width=200;
			
			container.y=70;
			container.width=this.actualWidth;
			container.height=this.actualHeight-70;
			
			rcl.x=this.actualWidth/2;
			rcl.y=220;
			_labelmsg.width=this.actualWidth;
			_labelmsg.y=rcl.y+60;
			
		}
				
		private function recupmescartes():void{
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonrecupcartefid");
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zurl.data=zdata;
			trace(zurl.url);
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");
				// on affiche en conséquence
				// parcours des msg
				rcl.stop();
				_labelmsg.text="";
				container.visible=true;
				if(zret.cartefids){
					if(zret.cartefids.length>0){
						for(var ii:uint=0;ii<zret.cartefids.length;ii++){
							trace("MSG=>"+ii+zret.cartefids[ii].NOMSHOP);
							ajouterunecarte(zret.cartefids[ii]);
						}
						if(zret.cartefids.length==1){
							_labelico.text="Ma carte de fidélité";
						} else {
							_labelico.text="Mes "+zret.cartefids.length+" cartes de fidélité";
						}
					} else {
						// pas de shop suivi
						_labelmsg.y=60;
						_labelmsg.text="Vous n'avez aucune carte de fidélité en cours.";
						var _labelmsg2:Label=new Label();
						_labelmsg2.nameList.add(ZoeMobileTheme.COMMONLABNOCO);
						_labelmsg2.text="Les cartes de fidélité s'activent automatiquement en \nsuivant un commerçant qui a mis en place cette fonctionnalité.";
						addChild(_labelmsg2);
						_labelmsg2.width=320;
						_labelmsg2.y=75;
						
						var imgsuivi:Image=new Image(Root.assets.getTexture("imagesuivicommerce"));
						addChild(imgsuivi);
						imgsuivi.y=105;
						imgsuivi.x=20;						
					}
				} else {
					rcl.stop();
					_labelmsg.text="Nous sommes désolé, \nune erreur technique est survenue";
				}
			}
		}
		private function ajouterunecarte(zunecarte:Object):void{
			trace("magasin:"+zunecarte.NOMSHOP);
			container.addChild(new Unecartefid(zunecarte));
		}
		
		private function clickmsg(event:starling.events.Event):void
		{
			// 
			trace("clickmsg")
//			this.dispatchEventWith("messagescreen");
		}
		
		private function onBackButton():void
		{
			trace("bacckbutton");
			partie.typenav=1;
			if(partie.fromscreen=="root"){
				partie.typenav=0;	
			} 
			
			this.dispatchEventWith(starling.events.Event.COMPLETE);
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