package com.zoe.screens
{
	import com.zoe.composants.Homercloader;
	import com.zoe.composants.Rcloader;
	import com.zoe.composants.Uneactu;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]

	public class MesmessagesScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var container:ScrollContainer;

		private var rcl:Homercloader;
		private var _labelmsg:Label;

		public function MesmessagesScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("messagescreen initialize");
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
			_iconmsg=new Image(Root.assets.getTexture("pictomessage"));
			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="Mes messages";
			addChild(_labelico);
						
/*			
			_btnretour=new starling.display.Button(Root.assets.getTexture("btnretour"));
			_btnretour.addEventListener(starling.events.Event.TRIGGERED, btnretourButton_triggeredHandler);
			addChild(_btnretour);			
*/
						
			_scrollvertical=new ScrollContainer();
//			addChild(_scrollvertical);
			
			_labelnom=new Label();
			_labelnom.y=10;
			_scrollvertical.addChild(_labelnom);
			
			var layout:TiledRowsLayout= new TiledRowsLayout();
			layout.typicalItemHeight=200;
			container= new ScrollContainer()
			//container.layout = layout;
			
				var ll:VerticalLayout=new VerticalLayout();
				ll.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_CENTER;
				ll.gap=10;
				container.layout=ll;
			
			addChild(container);
			container.visible=false;
			rcl=new Homercloader();
			addChild(rcl);	
			rcl.start();
			_labelmsg=new Label();
			_labelmsg.nameList.add(ZoeMobileTheme.ROOT_LABPRG);
			addChild(_labelmsg);
			_labelmsg.text="Récupération des messages";
			recupmessages();
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
			
			container.y=40;
			container.width=this.actualWidth;
			container.height=this.actualHeight-40;
			
			rcl.x=this.actualWidth/2;
			rcl.y=220;
			_labelmsg.width=this.actualWidth;
			_labelmsg.y=rcl.y+60;

			//_scrollvertical.y=30;
//			_scrollvertical.height=this.actualHeight-30;
//			_scrollvertical.width=this.actualWidth;
			
		}
		
		private function recupmessages():void{
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonrecupmessages");
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");
				trace(zret.msg);
				// on affiche en conséquence
				// parcours des msg
				rcl.stop();
				_labelmsg.text="";
				container.visible=true;
				if(zret.msg){
					if(zret.msg.length==0){
						_labelmsg.text="Vous n'avez aucun message pour l'instant.";
					} else {
						for(var ii:uint=0;ii<zret.msg.length;ii++){
//							trace("MSG=>"+ii+zret.msg[ii].DESCRIPTION);
							ajoutermessage(zret.msg[ii]);
						}
						if(zret.msg.length==1){
							_labelico.text="Mon message";
						} else {
							_labelico.text="Mes "+zret.msg.length+" messages";
						}
					}					
					/*_labelnom.text=zret.shop.NOMSHOP;
					_labeladresse.text=zret.shop.ADRESSESHOP;
					var z:feathers.controls.Button=new feathers.controls.Button();
					z.label="Suivre";
					_scrollvertical.addChild(z);
					z.y=500;
					var zmsg:feathers.controls.Button=new feathers.controls.Button();
					zmsg.label="messages";
					_scrollvertical.addChild(zmsg);
					zmsg.y=500;
					zmsg.x=100;
					zmsg.addEventListener(starling.events.Event.TRIGGERED,clickmsg);*/
				} else {
					rcl.stop();
					_labelmsg.text="Nous sommes désolé, \nune erreur technique est survenue";
				}
			}
		}
		private function ajoutermessage(zmsg:Object):void{
			trace("magasin:"+zmsg.NOMSHOP);
			container.addChild(new Uneactu(zmsg));
		}
		
		private function clickmsg(event:starling.events.Event):void
		{
			// 
			trace("clickmsg")
			this.dispatchEventWith("messagescreen");
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