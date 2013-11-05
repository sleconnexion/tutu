package com.zoe.screens
{
	import com.zoe.composants.Uneadresse;
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

	public class MesadressesScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var container:ScrollContainer;
		
		private var _labderniereadresse:Label;
		public function MesadressesScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("recupmesadresses initialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK);
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);

			// zone du milieu
			_iconmsg=new Image(Root.assets.getTexture("pictoadresse"));
			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="Mes adresses";
			addChild(_labelico);
						
			
//			list.itemRendererProperties.iconSourceField = "thumbnail";
			
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
			// Maison,Bureau, derniere recherche
			
			//container.addChild(
			recupmesadresses();
			
			
			// test			
			
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
			
			container.y=70;
			container.width=this.actualWidth;
			container.height=this.actualHeight-70;

			//_scrollvertical.y=30;
//			_scrollvertical.height=this.actualHeight-30;
//			_scrollvertical.width=this.actualWidth;
			
		}
		
		private function recupmesadresses():void{
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonrecupmesadresses?rnd="+Math.random());
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			var autreadre:Boolean=false;
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");	
				if(zret.adressemaison){
					trace("maison ok");
					ajouteradresseh(zret.adressemaison,Uneadresse.MAISON);
				} else {
					trace("maison ko");
					ajouteradresseh(null,Uneadresse.MAISON);
				}
				if(zret.adressebureau){
					trace("bureau ok");
					ajouteradresseh(zret.adressebureau,Uneadresse.BUREAU);
				} else {
					trace("bureau ko");
					ajouteradresseh(null,Uneadresse.BUREAU);
				}
				
				_labderniereadresse=new Label();
				_labderniereadresse.nameList.add(ZoeMobileTheme.MESADRESSESTITREDER);
				_labderniereadresse.text="Mes dernières adresses";
				_labderniereadresse.width=200;
				container.addChild(_labderniereadresse);
				
				
				if(zret.adresses){
					for(var ii:uint=0;ii<zret.adresses.length;ii++){
						trace("MSG=>"+ii+zret.adresses[ii].ADRESSELIB);
						if(zret.adresses[ii].TYPEADRESSE>1){
							autreadre=true;
							ajouteradresse(zret.adresses[ii]);
						}
					}					
				}
				if(!autreadre){
					container.removeChild(_labderniereadresse);
				}
			}
		}
		private function ajouteradresseh(zadresse:Object,ztype:String):void{
			container.addChild(new Uneadresse(zadresse,ztype));
		}
		private function ajouteradresse(zadresse:Object):void{
			container.addChild(new Uneadresse(zadresse,""));
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
			Root.ouvrircarto();
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